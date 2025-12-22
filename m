Return-Path: <linux-pci+bounces-43535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D16FCD6C70
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 18:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E26C301CC68
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 17:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9547933555B;
	Mon, 22 Dec 2025 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQMnjwB6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IteeYhpH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0E33374B
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766422957; cv=none; b=iz0KUpzXNS35E8vHUhW16ECgaW6Vjfk0/IvDecEysLJfPR5DVIYmve+Clq054lhUj/6MGGvD6PYbpyHnk4M+fDw9eLpM6RYN0pOjEnsuP9wm0UJcTpmnhWlPAZYdAlLGvr1NqeiaQe1jQnx9KdGo1WB5dNGs1jFex0zDRLokoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766422957; c=relaxed/simple;
	bh=X2wWtZnXX+I/oXqvtUQbyTZW/mFP0hV7GbITAwxX9Rk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=a3s988aP1JjergbjPym4n9jwMMh5z2kncohIgmdOHIjwcXF4s4PeYdEDgnrXIXTMdKyRpG/fORop9bhfGjE0gRCO8Heb4d+vq9jk3SndV8Yj6EuB3SKN/aBJYShgOdfErHt1WzTgsyzA8nDMWd8RRBAevjIwNaBgJdYpcKPheWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQMnjwB6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IteeYhpH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMEC4Vp2199005
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 17:02:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yp2RMDHYd3KhktISO6jK7zhxZreDnJv8OYT7HQAs42k=; b=WQMnjwB66gwdW62R
	NJptTlmB7Qo6HsBaPOd2eYKPEY4bEAnyoIf76Cia+E+0PdYnnYjv9Oq2XMkrw6mu
	axqLCB8+1c4W2iKoXaqXIqOtpB0gCi+5T1jXBffDT5vLnT16XjvawVkpdKyAt+k6
	jdnZhIqbCj1JpE2Oa9LOapFOU48+60uZ5ONw8+VaSKoKs1Ss5ywl+SCWwleN/12T
	wFHqqyP1qTh1JDoWKPlMz5jdNRpyLvssHrQ1GLNoHPSgt/OvF61Co64N5q3sHHsX
	IeOQbU3V1XZza5ge0vnovo5SaeACEigCpU6YvMMis7afS9is6bQ5vc+4Y1hx2EQS
	pPbZ/A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b73fws5jk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 17:02:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34ab459c051so10944180a91.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 09:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766422952; x=1767027752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yp2RMDHYd3KhktISO6jK7zhxZreDnJv8OYT7HQAs42k=;
        b=IteeYhpH+1rZetA3ChaEAGPnbdrOvSaXX+a4KQwrNBpDi7GPGaD6qLG07JiVTAfqe0
         a8OqTy/QlZKi6HoeFxvBz1I7LJUFGzkSzYF5UppnnjMv8sznhX7HvlRFz6WouG1KoYCk
         WcHmsrS1lgb+6iH3qQvMD09UYGWhwARQZ9A5smxekFdSC48RgRqQKguBJQ3gimDJFRVu
         EfR0t6eHETMLsck+JWSN7X5pLYnyg/ei0k2ehLDP4YEWz9TADVmnzif0VKWVKcL+Dea/
         2p6QWJcsFBaXzkjdMiYbEFaCJ0NWLI2ytaqK5CuTqjB2Jlg+WSZIxakogCj7D1aLPws1
         PX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766422952; x=1767027752;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yp2RMDHYd3KhktISO6jK7zhxZreDnJv8OYT7HQAs42k=;
        b=UDkQOQdyp8B8+UwmnnhssxBj28Rgaq/XMVTAIlbFbefBA03aOqxiqpweMnHEoDJ975
         Xt+b7Wjzz0Xo5BITsFS2b6hstGfpZ8q9Z8QOLb6dvkT0aCBENd5qaFUEy/vtxx6g5nZe
         F+JJqDEXR2RHgnWc8UDtqgW5irR56XpnoUyYJeMnmpbQU+OC8oVRTtw/XV3ehStnm/Sx
         aEQAVv+4h04oZ8TEXdA6vJcEmAzW1ON8Y/t2iyNz//yNF3+PfZS5e7G6D8pwgnaPhwWe
         2c6Kf+/Fc3eNmMFaq2yx/Jsj5mcPNob4MmHrKYnx0CSBw3w2RxL97A+oOMfAMk46lf/B
         Otiw==
X-Forwarded-Encrypted: i=1; AJvYcCWgMJ9JodhbJmLx6ftp5NTGmaWhJBLtFzw79YBqLJaIumNKrXr6UUpmeF/416DAp8cgtVQtLOqR/fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJ+XQVfNHLMHCgkIyVoM7+etN6lAueflVrqyuffPZYbd6f1JE
	HV9Aon357cxuoxaUCh8EkhSqZzUKO8BD0Jb4XkQR58rcWL+lu3Rkh6NcdbSumGE+5lN6lFhG6UF
	Cm6EqStXrWsG33ENCO3/CnVU4kyyms2uYZFsAo3kiJoVH4c4h5e7ZMNVkkhL5Ek4=
X-Gm-Gg: AY/fxX4u7r4C1x8oGlou9Q6Iw30bRHkq7FniY+tllOZsFfIlEt8z4F0KTqoQfzkqIdO
	T5W4NHhz54AGjj8no/bvc4JdlaOXS7vwBlU7POJuCjicRx9sbtZ5SliGoPTeEM1cyg8kbbWyIFe
	3vlHTDI9cB20qE2wev43MJ2cuCMm0HAV35CPUIi8Rv4d19cEbB8UGDxSAiRdO20eC40gEIE6aqg
	axjcd9xrXVEw9IXA1PqwI/zmiNJ70E7n8XMawSgORbt3Wk+5WN9mM/z9F3c/zf6x49BkV7aGHXM
	7VYs4W2n8sevuyNg/jv3KwW02m/OicCNf2/faJoA892ZHqnzgglmKrezp2qpFlX1E0uPFTci77+
	h0vq9hvMr
X-Received: by 2002:a17:90b:3844:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-34e9213011amr10256213a91.6.1766422951531;
        Mon, 22 Dec 2025 09:02:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhxvYwCBLtPVF5mS7w3vV1awrjYvqTGweCD6BTnP0tnreJxB27rzmNxHnp8YPmNFLzmV8T+A==
X-Received: by 2002:a17:90b:3844:b0:33e:2d0f:479b with SMTP id 98e67ed59e1d1-34e9213011amr10256154a91.6.1766422950785;
        Mon, 22 Dec 2025 09:02:30 -0800 (PST)
Received: from [192.168.1.102] ([120.60.139.28])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e70d4f887sm13636763a91.3.2025.12.22.09.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 09:02:30 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
In-Reply-To: <20251222064207.3246632-8-cassel@kernel.org>
References: <20251222064207.3246632-8-cassel@kernel.org>
Subject: Re: [PATCH v2 0/6] PCI: dwc: Revert Link Up IRQ support
Message-Id: <176642294649.11053.7692165747212741983.b4-ty@kernel.org>
Date: Mon, 22 Dec 2025 22:32:26 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=ELgLElZC c=1 sm=1 tr=0 ts=694979a9 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=wbxd9xFQoh2bOL7BUxlcyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=875CWLFNMCvb7f9f5gwA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDE1NiBTYWx0ZWRfX223zFTcdrds5
 iwqqoeBsQtinu2GXo3CSrGyBSwBg8lcOCFqvwz2kTkTKC5ZaOrCvR1Hm9q74kOWH3VHsrWgVZ6I
 OZKIC9xEymUagTLh8ZNyBsmld5yVhREggNGbdxjQAaig1qQkN0b6T4z1gjkLgPfmp/u+KveRVu+
 5JW8cQNCBwZh+7UhNBXZfMIrWh3d17BopUcvuvx2aI7NgkTURXdkWtWKO7L9WnDUobYmGmktkA7
 PB7bHdZaSv+GcoluDZKnlTzKqC0niLmG6hdNGVg3tM9dHqS/qH368gwlrYBmsiS5rwOHpY6COse
 +mGeZJiXSHvl1qx+TFViHRtS7Uje0Cuc+2FRvN7HOdyJnbYep9EZdvMfTG9l5yemVQxvadauSpG
 ywaNk3Rv+crvtD/wdyuAS+HlB2scEoKX1FC4VwGrcD30mmRdMZB91oNhkIrV4T4zJrDtFsHXMsx
 zdiSF9cNbD++VAip7nQ==
X-Proofpoint-GUID: VzRm6RgTL5GdkQ_ypu16dX8RvqdCyh7w
X-Proofpoint-ORIG-GUID: VzRm6RgTL5GdkQ_ypu16dX8RvqdCyh7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-22_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512220156


On Mon, 22 Dec 2025 07:42:07 +0100, Niklas Cassel wrote:
> Revert all patches related to pcie-designware Root Complex Link Up IRQ
> support.
> 
> While this fake hotplugging was a nice idea, it has shown that this feature
> does not handle PCIe switches correctly:
> pci_bus 0004:43: busn_res: can not insert [bus 43-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:43: busn_res: [bus 43-41] end is updated to 43
> pci_bus 0004:43: busn_res: can not insert [bus 43] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:00.0: devices behind bridge are unusable because [bus 43] cannot be assigned for them
> pci_bus 0004:44: busn_res: can not insert [bus 44-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:44: busn_res: [bus 44-41] end is updated to 44
> pci_bus 0004:44: busn_res: can not insert [bus 44] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:02.0: devices behind bridge are unusable because [bus 44] cannot be assigned for them
> pci_bus 0004:45: busn_res: can not insert [bus 45-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:45: busn_res: [bus 45-41] end is updated to 45
> pci_bus 0004:45: busn_res: can not insert [bus 45] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:06.0: devices behind bridge are unusable because [bus 45] cannot be assigned for them
> pci_bus 0004:46: busn_res: can not insert [bus 46-41] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci_bus 0004:46: busn_res: [bus 46-41] end is updated to 46
> pci_bus 0004:46: busn_res: can not insert [bus 46] under [bus 42-41] (conflicts with (null) [bus 42-41])
> pci 0004:42:0e.0: devices behind bridge are unusable because [bus 46] cannot be assigned for them
> pci_bus 0004:42: busn_res: [bus 42-41] end is updated to 46
> pci_bus 0004:42: busn_res: can not insert [bus 42-46] under [bus 41] (conflicts with (null) [bus 41])
> pci 0004:41:00.0: devices behind bridge are unusable because [bus 42-46] cannot be assigned for them
> pcieport 0004:40:00.0: bridge has subordinate 41 but max busn 46
> 
> [...]

Applied, thanks!

[1/6] Revert "PCI: dw-rockchip: Don't wait for link since we can detect Link Up"
      commit: fc6298086bfacaa7003b0bd1da4e4f42b29f7d77
[2/6] Revert "PCI: dw-rockchip: Enumerate endpoints based on dll_link_up IRQ"
      commit: 180c3cfe36786d261a55da52a161f9e279b19a6f
[3/6] Revert "PCI: qcom: Don't wait for link if we can detect Link Up"
      commit: e9ce5b3804436301ab343bc14203a4c14b336d1b
[4/6] Revert "PCI: qcom: Enable MSI interrupts together with Link up if 'Global IRQ' is supported"
      commit: 7ebdefb87942073679e56cfbc5a72e8fc5441bfc
[5/6] Revert "PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt"
      commit: 9a9793b55854422652ea92625e48277c4651c0fd
[6/6] Revert "PCI: dwc: Don't wait for link up if driver can detect Link Up event"
      commit: 142d5869f6eec3110adda0ad2d931f5b3c22371d

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


