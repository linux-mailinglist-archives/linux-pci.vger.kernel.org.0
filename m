Return-Path: <linux-pci+bounces-13550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 962E6986CBB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 08:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52466281EAB
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 06:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A9818786B;
	Thu, 26 Sep 2024 06:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnETtKbP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC2224D6;
	Thu, 26 Sep 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727333206; cv=none; b=WU2Hx8jLzqkzFk/f9lmMLXNLoY7YNWar0u12Tf21HjamII9V7yzjjBUc0DK2/VYoR5cKz95CYjXEu+pLXi7my2GDfK1DwHiQNCWswMURkhLYyDA71yCgp5E1xUC4WqNHZcf3NCvnMQmqC1N3Mfd397tn8iFrmxFRhKSSMs9C+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727333206; c=relaxed/simple;
	bh=Tns3qoxP0G8x4U1Q0cR6+joPa3TtIknuQmYwLgvK2iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qsi+0vx9M/jGuGfHrohzYEyoM5OFeS6jy9YOfOfIisr6YEZxwpgo4ddrBxllLqC1h6Rl2FXWR8hKl3VeFb4zMKFkkcy7d7kIKKS2A2HvTBelctw0k+FDjvx50BLHKghaug+Og7YOcwOpDk1+h6Z1HWGzZohLSt3/LhIyv9kzhQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnETtKbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE501C4CEC5;
	Thu, 26 Sep 2024 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727333205;
	bh=Tns3qoxP0G8x4U1Q0cR6+joPa3TtIknuQmYwLgvK2iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NnETtKbPuio878p0kPHmZF3xmuo0rJuBDrY4dWhv4KUIY+uyt4AD9wvt+efHTAfWZ
	 5HtX2VmmQ1ubBoxfau7BFM2YUPLgRCW+krwMfMqvPqwatsNg5GOLl8FwyeTx+5gGgj
	 zX8WGfywxIEy0ancw+63qh+VRsI+G9hDyiw34JiTPME97sM+3UNbFMJq8iy2O/SAly
	 LcmXwlaP65nrBmJIiK/zxA3eocT8AJayx+k8SobkoORRKxe2PZpGIPbUkfjw4urneV
	 SDYm1rM3iaPGoqIQVLFVOwd7YetFKtAK+xksPk3rpGDH45L4XfEbVxQT27RpAybuXW
	 MubyNQvoNBaeg==
Date: Thu, 26 Sep 2024 08:46:42 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, kwilczynski@kernel.org, bhelgaas@google.com, 
	lpieralisi@kernel.org, frank.li@nxp.com, robh+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com, 
	s.hauer@pengutronix.de, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kernel@pengutronix.de, 
	imx@lists.linux.dev
Subject: Re: [PATCH v3 1/9] dt-bindings: imx6q-pcie: Add ref clock for i.MX95
 PCIe RC
Message-ID: <3yqsh7ilzg5i43taxmb4px76434z7p7x7ubcgsnmlyqysio5xv@7dkxfki42lu7>
References: <1727330873-17486-1-git-send-email-hongxing.zhu@nxp.com>
 <1727330873-17486-2-git-send-email-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727330873-17486-2-git-send-email-hongxing.zhu@nxp.com>

On Thu, Sep 26, 2024 at 02:07:45PM +0800, Richard Zhu wrote:
> Previous reference clock of i.MX95 PCIe RC is on when system boot to
> kernel. But boot firmware change the behavor, it is off when boot. So it
> needs be turn on when it is used. Also it needs be turn off/on when suspend
> and resume.
> 
> Add one ref clock for i.MX95 PCIe RC. Increase clocks' maxItems to 5 and keep
> the same restriction with other compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


