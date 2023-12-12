Return-Path: <linux-pci+bounces-794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D0280E8F1
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 11:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4F1F218DE
	for <lists+linux-pci@lfdr.de>; Tue, 12 Dec 2023 10:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC585A104;
	Tue, 12 Dec 2023 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opux/Xgf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB245953D;
	Tue, 12 Dec 2023 10:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E53C433C7;
	Tue, 12 Dec 2023 10:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702376335;
	bh=BDA09IhOdJW1cajZlzV19+AKYjAHgvythLG7ITpYD98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=opux/XgfjUHFZVdwwdF32fgT8kROdV23JLpSodnxXNW1p9Ts2iGOQvYSKzLcpvGvx
	 G2vB9h093GLyD1BSff6rqzZWok2ekTyi0z9QqE+vVFZJKI2erjVidH3ri/MrB9Qng+
	 ap6y2Vqm/q2f1W0q2y/Wyb2ML5IX83HpvAnb3TvjfTDTraqKCpjLIOxIzZYUK3tU4q
	 +AKtQnX/JfXUyBXgKJDThmSQZS+b18SqxrG2TfCLKxR0vidNMQTsz6mv89AZrWRXoO
	 k0ngUxsjIqqO+g/UkpsRmNY9dRd3gVH/TNyJ9r0KAwGjabnzjHFXwk4WWEmLdf98Eu
	 COTdTV31JHAKA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	bhelgaas@google.com,
	imx@lists.linux.dev,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	minghuan.Lian@nxp.com,
	mingkai.hu@nxp.com,
	robh@kernel.org,
	roy.zang@nxp.com
Subject: Re: [PATCH v6 0/4] PCI: layerscape: Add suspend/resume support for ls1043 and ls1021
Date: Tue, 12 Dec 2023 11:18:47 +0100
Message-Id: <170237631077.45230.13455897797263324456.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204160829.2498703-1-Frank.Li@nxp.com>
References: <20231204160829.2498703-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 04 Dec 2023 11:08:25 -0500, Frank Li wrote:
> Add suspend/resume support for ls1043 and ls1021.
> 
> Change log see each patch
> 
> Frank Li (4):
>   PCI: layerscape: Add function pointer for exit_from_l2()
>   PCI: layerscape: Add suspend/resume for ls1021a
>   PCI: layerscape(ep): Rename pf_* as pf_lut_*
>   PCI: layerscape: Add suspend/resume for ls1043a
> 
> [...]

Applied to controller/layerscape, thanks!

[1/4] PCI: layerscape: Add function pointer for exit_from_l2()
      https://git.kernel.org/pci/pci/c/123971a193d9
[2/4] PCI: layerscape: Add suspend/resume for ls1021a
      https://git.kernel.org/pci/pci/c/6f8a41ba2623
[3/4] PCI: layerscape(ep): Rename pf_* as pf_lut_*
      https://git.kernel.org/pci/pci/c/762ef94b45d9
[4/4] PCI: layerscape: Add suspend/resume for ls1043a
      https://git.kernel.org/pci/pci/c/27b3bcbf8a79

Thanks,
Lorenzo

