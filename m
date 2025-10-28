Return-Path: <linux-pci+bounces-39574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A10C16B87
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 21:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 657484F03B2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 20:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6335534F47D;
	Tue, 28 Oct 2025 20:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="jXNDQ/aH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADD218626;
	Tue, 28 Oct 2025 20:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681857; cv=none; b=Q7+o/VHJlidqHQMQU9LQGnJybdc5tnGYxVqeynCNZXkwKmdNSfbRasjyS3cDDZoxYaXuvIdr6inzhdpF4JeymIxuJ3PagJVCHuTp/ZOep9qBuQz398zo8D6arvMpfH1na/tZ1jgA8sWcKmNmIBbtrYZtXTf5UKtdT3RspC+L7YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681857; c=relaxed/simple;
	bh=FTDvTxIZzeDNpOgOOnihA/zW/npIPvoaXcvipQNNMt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KCgREGW+/cILFoV6pl0UGZQR9vP5O2d31/X887TWRdRvmX8eJn79N+WYtA/eygbwc6dNBnERKT1q2Jy9clhM/JunBaxDWNp0IGCPMgRkn5KEm13/XUMn991QXy2icqPEQhkEo7Un7JqlkGV4tg9albLWnETmWZh0lhb8SLypoRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=jXNDQ/aH; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1761681852; x=1762286652; i=markus.elfring@web.de;
	bh=vdIRR0gXLsfY+ml4e6FTsMbQ2ZMNFqfdd/SP4uiFbHQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jXNDQ/aHWRdrCdHWlLRaawHCue7UtHYkdAXIeqCgcXe61xxicMBXMIRAx456phxb
	 FQqj4lPIDYHgJVHC4ljBLldXuwg0x1NxEOoj5x/+QjfrTva04D+ERPp6/Pxzf/m+3
	 PzK3zxltC3pjNhel6e8PUxTbuO3nbI8aTifMknsGLxvZWoE1mrR8CnWrV+0bBR0q4
	 cBE8GtLA7LHJ70E5K6BAqBZiRljGHVbRgFjOSs6NupYskAr0epjr5xcvS/e4frFG8
	 hR+GdglbNwFYbK8jllTETw/Ga0sghuJuqmATwJ/4vm4yz77gqX8z/mUt8vVjltBYQ
	 zKWfTEqlDVEGCHzTmQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.187]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N5CQT-1wEQwR18aL-00vyJ0; Tue, 28
 Oct 2025 20:58:50 +0100
Message-ID: <e6c75370-b127-4b41-8aef-e5012150ec94@web.de>
Date: Tue, 28 Oct 2025 20:58:48 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v? 2/2] PCI: j721e: Use inline reset GPIO assignment and
 drop local variable
To: Anand Moon <linux.amoon@gmail.com>, linux-omap@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
References: <20251028154229.6774-1-linux.amoon@gmail.com>
 <20251028154229.6774-3-linux.amoon@gmail.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251028154229.6774-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:flSGfgFEBOxbSY1So0TI+gtIAxqlRfdGBuByOYvGGECjWy8/VDB
 zo3R/pCdXPN1mIzcxFZQA819z1SjecdZcI8drNpMT39Z1SunQGD5jWDrdY8kTi3T4pS9Pgr
 p6I7aQr1a2N1n6KyqhiL5UCNWV7Wwp6YbS/Ccn9FfwtbM/+i6GzCJy1L+Uk3PEDmUDNr66u
 MHA6r5AwylJdMs3juvp1w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:65CO7IhhkF4=;xn6ZrW0UxtovFCrD+lI2zagO2xK
 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
 6VuIQ==

=E2=80=A6> Thus removes a superfluous local variable, which simplifies con=
trol flow

       remove?                               Simplify?


> and improves code clarity without affecting functional behavior.

      improve?


Regards,
Markus

