Return-Path: <linux-pci+bounces-39241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B55C04587
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 06:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5CE3A8BB2
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58780219A8A;
	Fri, 24 Oct 2025 04:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="tTUfW6pz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72A125A9;
	Fri, 24 Oct 2025 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761280817; cv=pass; b=orbGDxAFcNJuTs3hYNvcO6LQ+Ohs+79hRopuUImGyn7VSnVBULovN0OFRZARpYxpabK2t3lNjWATVAiihGVWXy63YV50S2Aj/4WivBhzCQt0S7N+ryouSWqQCbK8VE2mV/PFrsU567CvYFEpvFU1RrB5OU87dBDBzHmzT8yzQCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761280817; c=relaxed/simple;
	bh=8xOh9GUFAGCox7+nAnKlrlJYUUu28V2s9qrW5IXPRKo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=CnfDOacookq7nAM6EsvyeXL7IJ6+2YvGv+xatvYr5q6e6ol1I6vAnRVOtWGfM0dlCceVkrc/8+WfQvGYwYNYKf7uDEZ2IXdyKgwgYyGBkL5B8n4PV1Z19ZVU/SqcRZYn4DvJVJRlTBddNT93YtDsCYdFnCWtsBrkVG2MdHszhr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; spf=none smtp.mailfrom=xenosoft.de; dkim=pass (2048-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b=tTUfW6pz; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=xenosoft.de
ARC-Seal: i=1; a=rsa-sha256; t=1761280092; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pmeDQOkGAYfpG9ulR3RtsQiQ+CTCWFh30kP2trRjiD4fNmtSYF8WkejbFsD2+r5fyg
    97kIYrNXxDTlgkr6WS7IqUQ/tqjtSe2r/HtWR2IhR5NyQP/lgJHanl0SnwnWiE6lxQWl
    EyRb/ct3HAS80szrCsyiCrwNudvrTjoWZ/N//CbOIpihNX6jrQl6cr1CoiPkFNO4GOdO
    lcFcM8uDn4e/p3vZ39SbNQ2wXAeiVNCPATf/YcIgOI0TwwH7SJUeKj4ig/ue/l040k/0
    FvTvgQCpAffw792RNhbRXv8sy49XgbiGgaEpcGKTBtz5hf9y+PJkvCt5zILPDbk2hvUe
    PnHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1761280092;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oK2G3VTMLLo2HkG9J5SCJGjImSRIoXFlhPE5LjCqFBc=;
    b=ZMPYvrGnFNf5W0TBJPG+0ko4+FUMruGHCeNB58f51anumH1AZAuoQfgrXfqf8K8W3i
    ZkMrRa5xP3Ik3UpCrtPQqvyBVmRn0a1eVyMbC493k8oMysAzQBKEZBfvZqbIW99/EkAL
    YlorDZKrYo91z7E3+a7ZMFznonFj6e3vfSuDiwp2NXZJEO8J5MFK+sn7OZtsXdMLsjfn
    zfw78WtzB7kd53iF2GwnBQ5Mh6+L9FSD0HqVWjAVpswyi0jCQQNEjvSPcui+C2DyBp9Y
    0+NBL8QWrzGrVqdh1Ebp38ek92XjXgoqKrnvmphx81GKxTHFfZZ/84RbQxMWfw66n/QO
    nx/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1761280092;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=oK2G3VTMLLo2HkG9J5SCJGjImSRIoXFlhPE5LjCqFBc=;
    b=tTUfW6pzZ4tvboyY5Cnxn65DZ1wIeYbY1MWSfZRblGiIC9H/bFZR82VMDdexAsG6/t
    S68MGFE+knoO9gupyypUYaxeC991Ta8uBHkQ+j5/CmIB0JTFlMIZT5xDk/qDEr/tfzKi
    6j6KRwVEBQmq79u2DPBA3mX5ikQRGMwp3rIanqdz4SvHnmrNMJWcW/fUxuTYCapfuYTb
    M5vL1H1r2jR+DMGOYzal7+BXu8eIp97V3PZtVS8HD+FapCsfMTjQ4i1eux+WNzKOCuPu
    4Kr5fWWvfQ9qoAkB7Q5EhZhn2kkMKBsIYE3iQH5CfpeLATfLAy9cVmdHNELAOgk2tnCs
    IjHg==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIi+l6Rvg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 53.4.2 DYNA|AUTH)
    with ESMTPSA id e2886619O4SB2Ej
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Oct 2025 06:28:11 +0200 (CEST)
Subject: Re: [PATCH] PCI/ASPM: Enable only L0s and L1 for devicetree platforms
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 FUKAUMI Naoki <naoki@radxa.com>, Herve Codina <herve.codina@bootlin.com>,
 Diederik de Haas <diederik@cknow-tech.com>, Dragan Simic
 <dsimic@manjaro.org>, linuxppc-dev@lists.ozlabs.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, mad skateman <madskateman@gmail.com>,
 hypexed@yahoo.com.au, "R.T.Dickinson" <rtd2@xtra.co.nz>
References: <20251023182525.GA1306699@bhelgaas>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <b48b7ec8-09dd-fce4-c957-5fbbf66acd4e@xenosoft.de>
Date: Fri, 24 Oct 2025 06:28:11 +0200
X-Mailer: BrassMonkey/33.8.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20251023182525.GA1306699@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/10/25 20:25, Bjorn Helgaas wrote:
 >> ---
 >> I intend this for v6.18-rc3.
 >>
 >> I think it will fix the issues reported by Diederik and FUKAUMI 
Naoki (both
 >> on Rockchip).  I hope it will fix Christian's report on powerpc, but 
don't
 >> have confirmation.
 >>

Hello Bjorn,

Thanks a lot for fixing the issue. :-)

I will test the RC3 of kernel 6.18 with activated CONFIG_PCIEASPM and 
CONFIG_PCIEASPM_DEFAULT next week.

Have a nice weekend,

Christian

-- 
Sent with BrassMonkey 33.8.2 
(https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_33.8.2)

