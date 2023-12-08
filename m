Return-Path: <linux-pci+bounces-687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9180A5CC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 15:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1294C1F2134C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078151DFDC;
	Fri,  8 Dec 2023 14:39:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A007E19A4;
	Fri,  8 Dec 2023 06:39:00 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Smv0G6ChVz6K5rY;
	Fri,  8 Dec 2023 22:38:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A92FB140680;
	Fri,  8 Dec 2023 22:38:58 +0800 (CST)
Received: from localhost (10.126.175.81) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 14:38:58 +0000
Date: Fri, 8 Dec 2023 14:38:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Robert Richter <rrichter@amd.com>,
	Terry Bowman <terry.bowman@amd.com>, Kai-Heng Feng
	<kai.heng.feng@canonical.com>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/3] PCI/AER: Use explicit register sizes for struct
 members
Message-ID: <20231208143857.000061f4@Huawei.com>
In-Reply-To: <20231206224231.732765-4-helgaas@kernel.org>
References: <20231206224231.732765-1-helgaas@kernel.org>
	<20231206224231.732765-4-helgaas@kernel.org>
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

On Wed,  6 Dec 2023 16:42:31 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> aer_irq() reads the AER Root Error Status and Error Source Identification
> (PCI_ERR_ROOT_STATUS and PCI_ERR_ROOT_ERR_SRC) registers directly into
> struct aer_err_source.  Both registers are 32 bits, so declare the members
> explicitly as "u32" instead of "unsigned int".
> 
> Similarly, aer_get_device_error_info() reads the AER Header Log
> (PCI_ERR_HEADER_LOG) registers, which are also 32 bits, into struct
> aer_header_log_regs.  Declare those members as "u32" as well.
> 
> No functional changes intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Another sensible cleanup. FWIW on such simple patches
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

