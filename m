Return-Path: <linux-pci+bounces-17492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D739DEFED
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 11:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB071636E1
	for <lists+linux-pci@lfdr.de>; Sat, 30 Nov 2024 10:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AD3155C9A;
	Sat, 30 Nov 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkzg3Ng8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD5512B93;
	Sat, 30 Nov 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732962491; cv=none; b=bVG7tfFALRYC5vSURsIJ7eZsenFRhUu2UkVrBmQYVbCkdycnPYhoNwaFv2QXza9mmjauFEa6ZZNVfIHTBRi+3u+uuOaaJ5FydmzySSuMHpmYDosog/epnfeu/f4YG/86/ZGqoQobkGnYDUwa84yh3WQR4dYRUJgWVXrfg5wy31c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732962491; c=relaxed/simple;
	bh=H0noXI74C/Zki/cAOUy3v09yRzJnW9gLLKsDYh9ILj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VLRDghHp173EoweLDDMIkKmV0v6foZeoFiyAhqnQ8AcUlJHRr25SuBxC35efjUUGdUTCf2sKp5x0iS9X2n8HXySyzxj91mvWOawd/tdU1QL5mZU4wOJgEvX77bsrvyHm+rDjiK17MhpkD3MNx4XgtfVuoXAyp5W2KOAHEQ1Sr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkzg3Ng8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB4C4CECC;
	Sat, 30 Nov 2024 10:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732962491;
	bh=H0noXI74C/Zki/cAOUy3v09yRzJnW9gLLKsDYh9ILj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lkzg3Ng8Nd3eRCvOR5+7VFIy11KPI7flKiR1AsNRfmZnUC/tuV7JKtiFhwetJbd9S
	 oDjTgoxJaCaSuieHu+qpH2hzSkgS5BtmHYbHFQbdKSpbBNlSP6JRvmE+2dXmS6XLMR
	 LEV7+x3VReDOmaNFj4CsWoDEkT6yIzhyeYOYoDa9nLM5YIu7br8Cwc4MB9RRQIRIth
	 no0I+bfsXLu/F0V+Ed0EDXk1WHXb0PrPvPpYpCZg5wRAfSoyBjT6XXjL28yE7mXCnm
	 hlTv1YOMDPxBEKA1uY56amW2K0UXZKSJk9pLnzsGqlH37gZKxhQEe2Mx7ndm7Vje3L
	 0MKI+2noO14UQ==
Message-ID: <db90b752-307c-4baa-9aea-c3fbb07e5cb3@kernel.org>
Date: Sat, 30 Nov 2024 19:28:08 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] PCI: rockchip-ep: Fix error code in
 rockchip_pcie_ep_init_ob_mem()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <8b0fefdf-0e5b-42bb-b1ee-ccdddd13856d@stanley.mountain>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <8b0fefdf-0e5b-42bb-b1ee-ccdddd13856d@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/30/24 19:01, Dan Carpenter wrote:
> Return -ENOMEM if pci_epc_mem_alloc_addr() fails.  Don't return success.
> 
> Fixes: c35a85126116 ("PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Oops. My bad :)

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

Note that this patch is in Linus tree now so the Fixes tag should be:

Fixes: 945648019466 ("PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory
allocations")

Thanks !

-- 
Damien Le Moal
Western Digital Research

