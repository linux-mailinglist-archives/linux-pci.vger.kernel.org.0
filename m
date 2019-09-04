Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 152F0A95AC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 23:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfIDV6D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 17:58:03 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:40417 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727722AbfIDV6D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 17:58:03 -0400
Received: by mail-yw1-f65.google.com with SMTP id k200so902ywa.7
        for <linux-pci@vger.kernel.org>; Wed, 04 Sep 2019 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KdggRfIEWHwDidUMqy/eIO7XzaWlWVIemOK6sJu9pIg=;
        b=Sx/9Wuryv7ZcxpRf+3YuT1j2DS9BRX+fpOeDlYQvIv9RR2v/+5VK/Jj96hML55Whal
         cT0yH0PzsjpOCN72ZhDgOBkuhLnIkL5KplBxneCdVzErugfJDjA/ANErrmnhj3VpX+GE
         UpH+fXxf/DKcsyQE9Njd4rsvLgOUn7v9QYCz9m3sdvD+nLGj9E0pvJUG8HgKinQqVOkx
         FFWPjCCyPfHcW2iNwA4S6am+ewKAeETftdpgNV0mQ8ur7FjiRn4Ybkdkk7VF49T63NRm
         +rI7dtDbvEAB1/FI1IiBMEQ/OTAZrXea+44ZzS+M+Lse12jnc0NIrqtMyEUHLGRwBzIs
         MFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KdggRfIEWHwDidUMqy/eIO7XzaWlWVIemOK6sJu9pIg=;
        b=ltzX2B+LvUuonGtyieL/QCdQwA6sePmNXz8B+yn2lKBTTh/ztJHfa53fpTzxE90iRD
         af+hBPvK+NoxUT81rPxRBv3H45Nija3ScfRAL1oIgyaUaWFLLq7/3V8yAPBFHQXKZ/i/
         PvEeqoOpFEDM5pH83tz3iTTV5sZXmXueDnoIHLc6eDdrknIc7cd22qttPe09JMsfQtTD
         ufT9n5kxOnQSl5tSV3D7UaPJaw23c+bwH+yE0QkBdJjKg9FGx/qKLwOSkzVM8J6/VSmB
         uNb/0jzMKxeVjzYdc7mKYQqb4eXh/GojEWzcwYhCp5BPwoNvVkUL1v0uV+dMLVOLE7T7
         DBiQ==
X-Gm-Message-State: APjAAAUmJ4BxJrRBZLSxXM8ht244W48kHIZdJKvxEz2L5zd2ZP8zHVwP
        L+06nScyinz1wrG/gbjAjs/6zA==
X-Google-Smtp-Source: APXvYqxok05LJ2Yjh1TMso4jiMxf+nC4YfHxuyPN6BYFDRai3K3/dHzNXlyFKztyKnyNQLJa/7EqYA==
X-Received: by 2002:a81:24c4:: with SMTP id k187mr68051ywk.84.1567634282734;
        Wed, 04 Sep 2019 14:58:02 -0700 (PDT)
Received: from jaxon.localdomain ([152.3.43.56])
        by smtp.gmail.com with ESMTPSA id l78sm40586ywb.66.2019.09.04.14.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:58:02 -0700 (PDT)
From:   Haotian Wang <haotian.wang@sifive.com>
To:     kishon@ti.com, mst@redhat.com, jasowang@redhat.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, haotian.wang@duke.edu
Subject: Re: [PATCH] pci: endpoint: functions: Add a virtnet EP function
Date:   Wed,  4 Sep 2019 17:58:01 -0400
Message-Id: <20190904215801.2971-1-haotian.wang@sifive.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <7067e657-5c8e-b724-fa6a-086fece6e6c3@redhat.com>
References: <7067e657-5c8e-b724-fa6a-086fece6e6c3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jason,

I have an additional comment regarding using vring.

On Tue, Sep 3, 2019 at 6:42 AM Jason Wang <jasowang@redhat.com> wrote:
> Kind of, in order to address the above limitation, you probably want to 
> implement a vringh based netdevice and driver. It will work like, 
> instead of trying to represent a virtio-net device to endpoint, 
> represent a new type of network device, it uses two vringh ring instead 
> virtio ring. The vringh ring is usually used to implement the 
> counterpart of virtio driver. The advantages are obvious:
> 
> - no need to deal with two sets of features, config space etc.
> - network specific, from the point of endpoint linux, it's not a virtio 
> device, no need to care about transport stuffs or embedding internal 
> virtio-net specific data structures
> - reuse the exist codes (vringh) to avoid duplicated bugs, implementing 
> a virtqueue is kind of challenge

With vringh.c, there is no easy way to interface with virtio_net.c.

vringh.c is linked with vhost/net.c nicely but again it's not easy to
interface vhost/net.c with the network stack of endpoint kernel. The
vhost drivers are not designed with the purpose of creating another
suite of virtual devices in the host kernel in the first place. If I try
to manually write code for this interfacing, it seems that I will do
duplicate work that virtio_net.c does.

There will be two more main disadvantages probably.

Firstly, there will be two layers of overheads. vhost/net.c uses
vringh.c to channel data buffers into some struct sockets. This is the
first layer of overhead. That the virtual network device will have to
use these sockets somehow adds another layer of overhead.

Secondly, probing, intialization and de-initialization of the virtual
network_device are already non-trivial. I'll likely copy this part
almost verbatim from virtio_net.c in the end. So in the end, there will
be more duplicate code.

Thank you for your patience!

Best,
Haotian
