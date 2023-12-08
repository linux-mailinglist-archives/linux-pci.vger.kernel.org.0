Return-Path: <linux-pci+bounces-686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D98B80A5C2
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 15:38:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DFAB1C20B79
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0400C1A262;
	Fri,  8 Dec 2023 14:38:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E719AE;
	Fri,  8 Dec 2023 06:38:06 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SmtzD3yjTz67XhB;
	Fri,  8 Dec 2023 22:38:00 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CBDF140D37;
	Fri,  8 Dec 2023 22:38:04 +0800 (CST)
Received: from localhost (10.126.175.81) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 14:38:03 +0000
Date: Fri, 8 Dec 2023 14:38:02 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Kai-Heng Feng
	<kai.heng.feng@canonical.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI/AER: Decode Requester ID when no error info
 found
Message-ID: <20231208143802.00007c3e@Huawei.com>
In-Reply-To: <20231206224231.732765-3-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
	<20231206224231.732765-3-helgaas@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed,  6 Dec 2023 16:42:30 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When a device with AER detects an error, it logs error information in its
> own AER Error Status registers.  It may send an Error Message to the Root
> Port (RCEC in the case of an RCiEP), which logs the fact that an Error
> Message was received (Root Error Status) and the Requester ID of the
> message source (Error Source Identification).
> 
> aer_print_port_info() prints the Requester ID from the Root Port Error
> Source in the usual Linux "bb:dd.f" format, but when find_source_device()
> finds no error details in the hierarchy below the Root Port, it printed the
> raw Requester ID without decoding it.
> 
> Decode the Requester ID in the usual Linux format so it matches other
> messages.
> 
> Sample message changes:
> 
>   - pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
>   - pcieport 0000:00:1c.5: AER: can't find device of ID00e5
>   + pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
>   + pcieport 0000:00:1c.5: AER: found no error details for 0000:00:1c.5
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


