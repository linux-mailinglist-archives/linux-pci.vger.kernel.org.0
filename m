Return-Path: <linux-pci+bounces-39453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E20BC0F908
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 18:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DACA34E3C4C
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 17:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16B30EF9A;
	Mon, 27 Oct 2025 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="SL0hpBWp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6EF30C62D;
	Mon, 27 Oct 2025 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585207; cv=pass; b=g94ngc3iw7kqr1EJEeu4IdiCfcXCzgR+wb/SWWprBhsp59b1KGYmdVMypRoWhpsZSVZd89FtCax1L5or3a7KmN/EFe4v1lrQecc+/d4+Ivhn0oJ/XEbJ5EbpjJSWGVsFePvDt/Hy3Td949kiNAub7fG4rVk/iI2qNu26+UKLe6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585207; c=relaxed/simple;
	bh=04iCvrZIlceUJNdaDAwAdOObmTgIe0zCKRadwa5hDAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZbdUiQAbxR16U9RCtMns+Rggr8zKYKcxyeSKAv/Sj5eatJgixSPSUu95sNAQYGh6V86jInQLs5upaWxyQ9Vwd7x2F4ICW5bd0DSPEWv+vnfNRpP2C7228D120LPbcidXINhdxhj2P06No61LNMGmpCm7AqxZdxX+I2g8kIRp6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=SL0hpBWp; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1761585147; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iSFk4OiuvL8e8Pzfi5fiJdD+jKLneJKnfcb8lL0E4JI+uUuy1Dc59tRlf7grT56CJT
    hlPyr8x6uZ9wvbSOB80yDuVVNpWPf4RkOI4kEHnhoidJqSTf6lcfnpf2ukt+tGQxLoYD
    jeZHGQAPVFmGHiRKMmDsblVWgAJyx7vw4VSzqeR/pQRqrn7uYmmbftwgSFZrdv8iWXVC
    q9iagLSBh/HqG87tvPHzK1HxVjARZXcw2DcBJRUVGEqqsMv5neueDvzNNjkuNxU9uQDK
    nLmu46nl0yqeqNQ2r84soFghuhnQVwfpksSAIrk3BdwpuS+oSO4KhL47VjNfkgFYLOcZ
    W65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761585147;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=13Eh27o4UqsOQ34xi8S2wPYjOon2zusfqlo4MpiYA2k=;
    b=cc/uHztL9qfmFGxvFRvXRx9jH9UoYtEnUjx4QioYc9Nt13EoyGJqXMHwJhZW/c/JBy
    X7ZHV8VNKQOezLsU6FCNK3UwxfL2RYp78dhXRQM4/hYjbZ+JyEQoqN721lE0Y0ZAG8rn
    93yzMW8gXVidoAQpQ03pbFb94doSwTvzsKT+lmBSa7jdOFJrAAMliXK58sJ4BlL7yLxS
    B2jXtAnT37s5BV0a8Rq+F5K4CavuJubSleN7dQC/3g33mRoSfFLweLgrAiCC9mH/FZTj
    Dz2CY4Xdpd4qVm8kDuOxT20SSQJjDWApdzGH5m/o+6JwVR3tx6C/x8A1PG6SQDeeHJej
    hrOA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761585147;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=13Eh27o4UqsOQ34xi8S2wPYjOon2zusfqlo4MpiYA2k=;
    b=SL0hpBWp9K5XPn08SzhMWLoaM3HAMUicwwKckYD30tB43wSmf3e8dn4uXATn4kLlPh
    RZFVde1tdkEbWD+9/aFM65RhN1Oqlqj05eOTEj9gSBl/M98fgVd+6XZsb0Zt1ThPhoCQ
    GUh74HjFHdCj0MPQH9fmMCbFi4+qh+dWi/rzHqyXWIlf++BrJwg7nn0b+X6/cvMo865i
    IrQAEjPI50xpcmTl6TnDQTjpmFXwN9hw0JZ7DwMombbaCRVOjr0+IL53zlOMl2dD7XRw
    uFWbnY0UPYH0sfXJE1+4QJ6bxd7tlG2hHGjlQL9JBnyyEtbYDgBh9tMmJyoaqnKLVawI
    Y7VQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+l7Rng"
Received: from [192.168.178.48]
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619RHCPBv7
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 27 Oct 2025 18:12:25 +0100 (CET)
Message-ID: <3aa95b26-7801-476e-840f-5976b0ee11c1@xenosoft.de>
Date: Mon, 27 Oct 2025 18:12:24 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
To: Bjorn Helgaas <helgaas@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pci@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Herve Codina <herve.codina@bootlin.com>,
 Diederik de Haas <diederik@cknow-tech.com>, Dragan Simic
 <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Frank Li <Frank.li@nxp.com>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 mad skateman <madskateman@gmail.com>, hypexed@yahoo.com.au
References: <20251024203924.GA1361677@bhelgaas>
Content-Language: de-DE
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20251024203924.GA1361677@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I activated CONFIG_PCIEASPM and CONFIG_PCIEASPM_DEFAULT again for the 
RC3 of kernel 6.18. Unfortunately my AMD Radeon HD6870 doesn't work with 
the latest patches.

But that doesn't matter because we disable the above kernel options by 
default. We don't need power management for PCI Express because of boot 
issues and performance issues.

Cheers,
Christian

