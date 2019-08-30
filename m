Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC74A2F73
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2019 08:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfH3GMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Aug 2019 02:12:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbfH3GMF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 30 Aug 2019 02:12:05 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE3FE3084025;
        Fri, 30 Aug 2019 06:12:04 +0000 (UTC)
Received: from [10.72.12.92] (ovpn-12-92.pek2.redhat.com [10.72.12.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A6315D717;
        Fri, 30 Aug 2019 06:11:59 +0000 (UTC)
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
To:     Haotian Wang <haotian.wang@sifive.com>, kishon@ti.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     mst@redhat.com, linux-pci@vger.kernel.org, haotian.wang@duke.edu
References: <20190823213145.2016-1-haotian.wang@sifive.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <f5e5dc8a-2e02-a675-8ab9-b2ab58640452@redhat.com>
Date:   Fri, 30 Aug 2019 14:11:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823213145.2016-1-haotian.wang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Fri, 30 Aug 2019 06:12:05 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019/8/24 上午5:31, Haotian Wang wrote:
> This endpoint function enables the PCI endpoint to establish a virtual
> ethernet link with the PCI host. The main features are:
>
> - Zero modification of PCI host kernel. The only requirement for the
>   PCI host is to enable virtio, virtio_pci, virtio_pci_legacy and
>   virito_net.
>
> - The virtual ethernet link is stable enough to support ordinary
>   capabilities of the Linux network stack. User space programs such as
>   ping, ssh, iperf and scp can run on the link without additional
>   hassle.
>
> - This function fits in the PCI endpoint framework
>   (drivers/pci/endpoint/) and makes API calls provided by virtio_net
>   (drivers/net/virtio_net.c). It does not depend on
>   architecture-specific or hardware-specific features.
>
> This function driver is tested on the following pair of systems. The PCI
> endpoint is a Xilinx VCU118 board programmed with a SiFive Linux-capable
> core running Linux 5.2. The PCI host is an x86_64 Intel(R) Core(TM)
> i3-6100 running unmodified Linux 5.2. The virtual link achieved a
> stable throughput of ~180KB/s during scp sessions of a 50M file. The
> PCI host could setup ip-forwarding and NAT to enable the PCI endpoint to
> have Internet access. Documentation for using this function driver is at
> Documentation/PCI/endpoint/pci-epf-virtio-howto.rst.
>
> Reference Docs,
> - Documentation/PCI/endpoint/pci-endpoint.rst. Initialization and
>   removal of endpoint function device and driver.
> - Documentation/PCI/endpoint/pci-endpoint-cfs.rst. Use configfs to
>   control bind, linkup and unbind behavior.
> - https://docs.oasis-open.org/virtio/virtio/v1.1/csprd01/virtio-v1.1-
>   csprd01.html, drivers/virtio/ and drivers/net/virtio_net.c. Algorithms
>   and data structures used by the virtio framework.


Interesting work, several questions:

- Is there a doc for this endpoint device?
- You refer virtio specification in the above, does it mean your device
is fully compatible with virtio (or only datapath is compatible?)
- What's the reason for introducing kthreads for some kinds of
translation or copying of descriptor?
- Is it possible to reuse e.g vringh (by introducing new accesor) and
virtio core codes?


Btw, I'm going to post mdev transport for virtio (with a sample of
vringh loopback device). Technically, this can go through mdev bus as well.

Thanks

