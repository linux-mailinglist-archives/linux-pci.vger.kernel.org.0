Return-Path: <linux-pci+bounces-32731-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE00B0DAF4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 15:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084FE56271B
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F36F2E9EC6;
	Tue, 22 Jul 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKdkPJku"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FA62882BB;
	Tue, 22 Jul 2025 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191443; cv=none; b=H4qr44v7UeaBYd3pIHhVQI1dsGt9lh/0+x7iLSuEOVITvdrxqA+jlxIXXjln6HNbgvIpCNPdTPlGb1jelv2vb8XLAE4mFWGCnEqW33LTEJ1lFJ62flMJK8PQ6pu5qw1VnjTLNITjGhubVN3tHGRPABC9sxSmZqfM21rrEw0Toqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191443; c=relaxed/simple;
	bh=7mFmuNX7jxwdHzGeVnnaIEXERSOB5a76i4j3QEz5V3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JIVhMR1vJDZAv0AfNrpKk0AkcFxa/lFQ8OwyVgX09mdh5gYpWbTPiXPcRMsqPDJmys/fzPJlTLWS0qtzV9bOuje1rAvzMUVcTmoU4wRPymJFmob0gRvQOQfErv/RiD+XZEnM3jAlyDAspYpdMhl7q6RgK+gfNuEADv/QJTTrIq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKdkPJku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FE8C4CEF6;
	Tue, 22 Jul 2025 13:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191442;
	bh=7mFmuNX7jxwdHzGeVnnaIEXERSOB5a76i4j3QEz5V3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kKdkPJkuEmnkarEbU7yP2kcVVtVeYD16fuqEzyOPzj6lqUhezuwHrh8df/jPb4uG0
	 l8nckVyAl/N/xlaSei/5fId8CvuhOZRqG7MMsRUk8DKSa0ZuEdwlpFzfNLBePFcO6L
	 1JhnEjeu1p1PuOiLmqphvPejZthvPee3YWNrsUQ9bMPyH8Iqj1+7u+zf2sJpubYK3v
	 VNkt3oPkV2AyWXNiybbYW47brnwkqo6td4CPygxVXw8dzT9XAv+B51ebWojnrco66l
	 o7SgqUJ3uOpX/RVIN1XeePA3GoJL1wgzyzGU0p3xGRI3BHc9Lqkk7A/Axk1Ah46DzX
	 KJkWEorqlbHQw==
From: Vinod Koul <vkoul@kernel.org>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
 krzk+dt@kernel.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
 mani@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 bhelgaas@google.com, johan+linaro@kernel.org, kishon@kernel.org, 
 neil.armstrong@linaro.org, abel.vesa@linaro.org, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com, 
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
In-Reply-To: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
References: <20250703095630.669044-1-ziyue.zhang@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v8 0/3] pci: qcom: Add QCS615 PCIe support
Message-Id: <175319143640.114152.11286071190627190841.b4-ty@kernel.org>
Date: Tue, 22 Jul 2025 19:07:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 03 Jul 2025 02:56:27 -0700, Ziyue Zhang wrote:
> This series adds document, phy, configs support for PCIe in QCS615.
> 
> This series depend on the dt-bindings change
> https://lore.kernel.org/all/20250521-topic-8150_pcie_drop_clocks-v1-0-3d42e84f6453@oss.qualcomm.com/
> 
> 

Applied, thanks!

[1/3] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings for QCS615
      commit: dfef90f29811b5b8bc6353e259cac6134a88671f

Best regards,
-- 
~Vinod



