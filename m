Return-Path: <linux-pci+bounces-25675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31226A85CB4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 14:15:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 211738C3C00
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E0629DB82;
	Fri, 11 Apr 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXfReTdO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12629B231;
	Fri, 11 Apr 2025 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744373475; cv=none; b=YODbD90u8rzHqG5/+ELgF0qxShph1NPOafTv1J/ux75yZRnAqmWXB6OX6YF7Pjssjg03YTEAvVi56py2DFyKLeekwotIJiqqlVCXdayye/2pwLrK0WprW1SLUdWNzfg4v/KwuDz98TnxadmE0VFvk5GkcZ26wMTjN3xsgXJoWwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744373475; c=relaxed/simple;
	bh=kbUcZPoXi79WtS45+fL3/oWI2wWgCZEwrEDv3Xo/gxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lmUneF1z3pZTDzLJHtakSDE2IGrE/1rTIvs/Z8wF6ThOARxLlTWrPJmoUheC6axdvlXnShK/tZ2knJ8DnBgQ1n2WBhR6MYyYtJ94v/cfxn3rf17nDWj9BjtqLWgGsV6Dafp1ekz5FaTQONdf/55CU0XRLlYZcLrYPIpllthuLYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXfReTdO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E48BC4CEE2;
	Fri, 11 Apr 2025 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744373475;
	bh=kbUcZPoXi79WtS45+fL3/oWI2wWgCZEwrEDv3Xo/gxY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=oXfReTdO98Js7+lVoMrKowkY/dHKuDTcIXRPKrWKJk5X7+RY5+egJLrKqFXdsYjEC
	 5wLKayQ1r3Tgymu3bg2fgBKj+3MbAanhYpUzqS3NE+uAs8XITlEqaTdh6svcJc68Mn
	 c3M/HAtl2EbjFc7+khBRMqryHMHJzNv5s4oAJdwvpSglnEjlQtOhUIRv6Tj8AXLoC1
	 IQV+9SQstnRyR+LX+GVypm2DDXIkhOeefXaTRdElniPQFX1u9NzQvR9F+7++Tes60S
	 vme+tAt7hKQiBD13P/PmV5PFVVCSgX487Ob9P2+rH02DvZS8hRw4kzKCRsZjC5cSlE
	 sLUxz2hT515OA==
From: Vinod Koul <vkoul@kernel.org>
To: Kishon Vijay Abraham I <kishon@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Nitheesh Sekar <quic_nsekar@quicinc.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Praveenkumar I <quic_ipkumar@quicinc.com>, 
 George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, 20250317100029.881286-1-quic_varada@quicinc.com, 
 20250317100029.881286-2-quic_varada@quicinc.com, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
References: <20250326-ipq5018-pcie-v7-0-e1828fef06c9@outlook.com>
Subject: Re: (subset) [PATCH v7 0/6] Enable IPQ5018 PCI support
Message-Id: <174437346895.673939.17282327012259130391.b4-ty@kernel.org>
Date: Fri, 11 Apr 2025 17:41:08 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 26 Mar 2025 12:10:54 +0400, George Moussalem wrote:
> This patch series adds the relevant phy and controller
> DT configurations for enabling PCI gen2 support
> on IPQ5018. IPQ5018 has two phys and two controllers,
> one dual-lane and one single-lane.
> 
> Last patch series (v3) submitted dates back to August 30, 2024.
> As I've worked to add IPQ5018 platform support in OpenWrt, I'm
> continuing the efforts to add Linux kernel support.
> 
> [...]

Applied, thanks!

[1/6] dt-bindings: phy: qcom: uniphy-pcie: Add ipq5018 compatible
      commit: aae29082b6620c664e97a1e2f2062abc6a58659d
[2/6] phy: qualcomm: qcom-uniphy-pcie 28LP add support for IPQ5018
      commit: dfc820d2f8a8ea90bbc02269b5362e3678e58cac

Best regards,
-- 
~Vinod



