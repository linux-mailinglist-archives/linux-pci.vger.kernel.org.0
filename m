Return-Path: <linux-pci+bounces-11044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61467942C7E
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A490283F90
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 10:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8801AE87D;
	Wed, 31 Jul 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjizwBrK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195C31AD9C8;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722423019; cv=none; b=GFq/6Q9p6SFkZG/AN8JEwTwPB/GYVf+j3kW60lE4k2FyAtxdumpE0wNrHKgQgAG9K5+y+8jJZjukJ2wdz4+kqubrkke+GtFQptPJZc/kVC29+S8oOUDpvqTvCprE0H2hBOmQQ8omi2RsUTkFqWgRw61MXGUEt9ZlkgwlvMLHhFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722423019; c=relaxed/simple;
	bh=9SpPkeVArnB3rJ4nPZ0WPdvcC8ctAG/YXTHNpaqeYTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BZ7jMTU4piFWl71rRvrRYfUVMqfvuo5Y/qCaPyvadN/THlLFCQVT/g9kqKwILXERz2/fD8OFiSs15CJOCeuiaV+mgLj9jjgDEDvqMnXqCuF0sAZPERPd7SHNsLZpMhIQ5ntpvz7SQKuZBU5HoJ4m46157D59gTiFeou2bMI1M7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjizwBrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADF4AC4DDF8;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722423018;
	bh=9SpPkeVArnB3rJ4nPZ0WPdvcC8ctAG/YXTHNpaqeYTk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=DjizwBrK7cTEZVihDNocrp8MBBartldGNOXR8giX5ZWDA3VtFYju0r/tBf6E9ELcK
	 nGiF5hZ3g5Br0GUE2zOnZBDiJzJLIJ8F6snkGFifwyiktTnDFQdsBoX7bfrdwiAZQs
	 HW/Gyers3LWZdABTiTS6peUbv9L530BINZLpeEStt7OTsH7u+aD83ItazL9Gl1I47x
	 jTlx6aQD1JgM5da0ZIdIZztu6B3YsIGHLiw1j6eLeUMBYaNHIDXmbFonMqZSp8/Ns6
	 EQJCcvDzEfwsVetijCHR8mf/uAMmVZSIsd/N3FdPwb0Uj6xofO2GQ6Cdq6BME1IZLL
	 iSY5Qy8aebaiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A017BC52D6D;
	Wed, 31 Jul 2024 10:50:18 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.linaro.org@kernel.org>
Date: Wed, 31 Jul 2024 16:20:12 +0530
Subject: [PATCH v3 09/13] arm64: dts: qcom: sa8775p: Add 'linux,pci-domain'
 to PCIe EP controller nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-pci-qcom-hotplug-v3-9-a1426afdee3b@linaro.org>
References: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
In-Reply-To: <20240731-pci-qcom-hotplug-v3-0-a1426afdee3b@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1289;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=YKSy5vPklQvLJA99UbdPy4mFyoiPQChYvArhByAGkpA=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmqhbkM82d8e+WMgMaI3vqUmCsTncdYX2eiPFOn
 D6P6KY6mfCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZqoW5AAKCRBVnxHm/pHO
 9YEMB/96o/GgxfmiCVskdaEk9lPriojnKoJwUFGZq0mTGD5vspGq5yt7OLqRTc/vStU7UIJY+a9
 3yHXH8lmdrhtjcvwvOlWDCzgwgxFOgh6MvqlWoyYVnJrXyOFy+F0eNMsiC0BoqfZOJsem28kgWT
 hP2l+54I7J/ulzCMjKc+rrRE3ffQq6YyPEheNyKoG3bZ/jWNpoHqodHXUqXXvLA5BUzWBjG0KRZ
 sWb9TNcPiz3rjPG53KFicTsoUTDDKbNS7CKp7kimQV8lwYrVqYRU66gVPePhCAn6ncejK+a4d1G
 cjpR1PG1aN2a1ISPBJYeZO3F/zor/dTi4OMRp/uLoEy4S+dS
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@linaro.org/default with auth_id=185
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reply-To: manivannan.sadhasivam@linaro.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

'linux,pci-domain' property provides the PCI domain number for the PCI
endpoint controllers in a SoC. If this property is not present, then an
unstable (across boots) unique number will be assigned.

Use this property to specify the domain number based on the actual hardware
instance of the PCI endpoint controllers in SA8775P SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 23f1b2e5e624..198b39abde97 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -4618,6 +4618,7 @@ pcie0_ep: pcie-ep@1c00000 {
 		phy-names = "pciephy";
 		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
 		num-lanes = <2>;
+		linux,pci-domain = <0>;
 
 		status = "disabled";
 	};
@@ -4775,6 +4776,7 @@ pcie1_ep: pcie-ep@1c10000 {
 		phy-names = "pciephy";
 		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
 		num-lanes = <4>;
+		linux,pci-domain = <1>;
 
 		status = "disabled";
 	};

-- 
2.25.1



