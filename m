Return-Path: <linux-pci+bounces-34915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38493B382C9
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 14:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ED581B661E8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 12:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401B629ACF7;
	Wed, 27 Aug 2025 12:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="if2hlFn7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF41A0711;
	Wed, 27 Aug 2025 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756298874; cv=none; b=eniGaoIBOpAoJ+K9zaCMPdAYqgrCa0aCcNydEFwrtbOliRHj6ryac7//5m13pQykqGT/EMB9m0hJdzuugm6epYbcyl8tjsh5Kdbg01wT2GbbUMaeFcatRUm22fX+tSxpgTj5aX5shAdQ1xZNlkp4h0TuEuuqGCizzLlTA0C9yH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756298874; c=relaxed/simple;
	bh=xUruCi2k+1duHtAUPHbdbOT0BVdL6VnSjr48neZmYCQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oY8LJRO5AVffPK1B8yRt1iGP3yb0y6k93oe2gv+90BfjVpm2FPqr6Uyx+ndMgu1NKfEASqRF7nW2dOJSzoPC7vf6j9TXexxMWIVIxHnxWATTVSBx0fl8JWiWQjbC7nFZzpr+OOS0sVzLYwz7gOLluNQSSHOPCeVY3l5poSud4iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=if2hlFn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9922C4CEEB;
	Wed, 27 Aug 2025 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756298873;
	bh=xUruCi2k+1duHtAUPHbdbOT0BVdL6VnSjr48neZmYCQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=if2hlFn7iVatis/yOuKmzahvxWuE1X4oWZe2jM/JimGXmMqWW5+xskJ+0ES5P3ZS8
	 4919W8wjqIaf2DGZ0l4X9BQ8VEF/OtFMly4pmhIXsv6f4k+PTExbvfV2M1wIYA8vqs
	 wuiyPjamha7RvEaWayy/ZBaKhxjeTLUO3KmaZL5Bsh8v89tzSLKf+FZ3Z231yGfEsW
	 H0ODSSk+CkDOzvwRrw2SZ/srOn1t4dH1nR5RfbNVUZFxzPnc9rvu8c69M0WE07VwQZ
	 mrDIGPYjbauWhoLaS0B6GEn7F3ZMZHzzGfzQFgrj4wTedZyEdgcVk+ojtrJh6kenWo
	 ubLkBA0Pz/YYg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>, 
 Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20250818142138.129327-2-krzysztof.kozlowski@linaro.org>
References: <20250818142138.129327-2-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: PCI: Correct example indentation
Message-Id: <175629886215.5618.15838466125684644462.b4-ty@kernel.org>
Date: Wed, 27 Aug 2025 18:17:42 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 18 Aug 2025 16:21:39 +0200, Krzysztof Kozlowski wrote:
> DTS example in the bindings should be indented with 2- or 4-spaces, so
> correct a mixture of different styles to keep consistent 4-spaces.
> 
> 

Applied, thanks!

[1/1] dt-bindings: PCI: Correct example indentation
      commit: 4edc575c5582550d0905f39c5e27f1f1f925fffa

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


