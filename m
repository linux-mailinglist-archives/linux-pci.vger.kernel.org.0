Return-Path: <linux-pci+bounces-1141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C7816A95
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 11:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8EAC1F22FB7
	for <lists+linux-pci@lfdr.de>; Mon, 18 Dec 2023 10:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FC912B9B;
	Mon, 18 Dec 2023 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W5c/SBi7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BB13FE6
	for <linux-pci@vger.kernel.org>; Mon, 18 Dec 2023 10:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E87C433C7;
	Mon, 18 Dec 2023 10:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702894211;
	bh=w4SB9MJAnBWuESxZQ+p66V5XwD5gotjkGtk4AS9q7VQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W5c/SBi7yw695hV2mJcd91y45MLnPmSvY+FuTHidGaYB9clKeK8zDZnZ+qsLnyoUw
	 6+NOGIyrIP1V9vOU5GYALEuDKxvOSOOmhOPy0Lqh1rG2viNeXK/VlxKmdgWCah2MUy
	 dRlsl4tddzt83rrIllmm7Kgaqbt7S8q1tFaEKqZQvYE1uS3hdnXWp5MfIA4yNiGoaB
	 K86VuE8rqeYa2LZl7Z2TfZO499PkcPEeRyveXBIXVMdFHV30hDCC5MyiACHblCK2Mx
	 6CH8Rkzsh2X5+Bc3eaHVZv2EP0heXaNXZ4JujqMFxCPe/j0UfhlQMberc2mNia8qIk
	 jz3HihoH5ah0g==
Message-ID: <af2d3079-e613-4e73-93b4-d1e7dc5b1353@kernel.org>
Date: Mon, 18 Dec 2023 19:10:08 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/16] Cleanup IRQ type definitions
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 Serge Semin <fancer.lancer@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
References: <20231201005236.GA504435@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231201005236.GA504435@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2023/12/01 9:52, Bjorn Helgaas wrote:
> Looks good to me, Damien.  Thanks for doing all this work.  I think
> Lorenzo or Krzysztof will pick this up, and we'll get it into -next.

Ping ? I do not see this series queued anywhere. Did I miss it ?

-- 
Damien Le Moal
Western Digital Research


