Return-Path: <linux-pci+bounces-1216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 788818198F3
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 08:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE0B1F24141
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 07:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D6D134A6;
	Wed, 20 Dec 2023 07:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4v8eU6P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD5F9F1
	for <linux-pci@vger.kernel.org>; Wed, 20 Dec 2023 07:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19959C433C8;
	Wed, 20 Dec 2023 07:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703055991;
	bh=aqzaxpXe6LTTVc8cTSBLr+98OD76iO090+q9kA7M6XE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e4v8eU6PDQi2xNor36bb6aGIQ/oNN/cwtgh2tSRBwAaoBQV0baNvK0ATNYfhRULe+
	 kgsY+/hvV9FPklWt5Rmrf7FLmLkY6FBUA/CoVS3bdLZWJtjzPM5fhp6lgsGemxL4zd
	 56UQoBLwAW7BveH4Wwunagk2x6Xtegs4N2iFZ1U56Qxds9eMoKcKi2YJn7FUdi9yUL
	 E3QcBjKa36jOjOl9RYJo4s796CSpzl5dguKP27RxO4oPqXo6meA/NNqKSX8RY3nKaC
	 ylz7OIGIL8ItgDvmCF+eH8mJgQ/PoWHHb7wTmkZBpAosbMfN0MckHJ2JogMk52TAPC
	 HiHXX+qdUWCyg==
Message-ID: <62e520d2-4327-461f-95a2-602f0800ebc6@kernel.org>
Date: Wed, 20 Dec 2023 16:06:27 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] PCI: designware-ep: Allow pci_epc_set_bar() update
 inbound map address
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>, Frank Li <Frank.li@nxp.com>,
 Vidya Sagar <vidyas@nvidia.com>, "helgaas@kernel.org" <helgaas@kernel.org>,
 "kishon@ti.com" <kishon@ti.com>,
 "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
 "kw@linux.com" <kw@linux.com>, "jingoohan1@gmail.com"
 <jingoohan1@gmail.com>,
 "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
 "lznuaa@gmail.com" <lznuaa@gmail.com>,
 "hongxing.zhu@nxp.com" <hongxing.zhu@nxp.com>,
 "jdmason@kudzu.us" <jdmason@kudzu.us>,
 "dave.jiang@intel.com" <dave.jiang@intel.com>,
 "allenbh@gmail.com" <allenbh@gmail.com>,
 "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20220222162355.32369-1-Frank.Li@nxp.com>
 <20220222162355.32369-2-Frank.Li@nxp.com> <ZXsRp+Lzg3x/nhk3@x1-carbon>
 <ZXsc57whj/3e/+zq@lizhi-Precision-Tower-5810> <ZXtkMC1ZjsgHMRvT@x1-carbon>
 <ZXtrG40SR81YAR6a@lizhi-Precision-Tower-5810>
 <ZXtzjIIl5oabviZI@lizhi-Precision-Tower-5810> <ZX13xhBm3RmshqgD@x1-carbon>
 <20231219175900.GA24515@thinkpad>
 <c33b8830-5237-438f-9aae-6905e9e538b8@kernel.org>
 <20231220060357.GA3544@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231220060357.GA3544@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/20/23 15:03, Manivannan Sadhasivam wrote:
>> We have core_init and link_up notifiers for EPF drivers. Adding link_down and
>> core_exit notifiers would make a lot of sense :) A core_reset notifier could
>> also be a solution.
>>
> 
> Yeah, I'm thinking along those lines.
> 
>> Adding that would also help EPF drivers to handle links going down temporarily
>> (which can happen). Right now, an EPF driver can only deal with such event by
>> tracking if it gets multiple link_up events.
>>
> 
> There is already link_down notifier that I introduced a while back. But it is
> only used by MHI_EPF driver.

I missed that. I need that notifier :)

-- 
Damien Le Moal
Western Digital Research


