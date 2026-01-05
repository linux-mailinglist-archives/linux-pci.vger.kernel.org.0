Return-Path: <linux-pci+bounces-43988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D549CF2828
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 09:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E1A43041573
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 08:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77520320CBB;
	Mon,  5 Jan 2026 08:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fO9vOUle";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XfQ4Jj0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF07313E07
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 08:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767602745; cv=none; b=UrwYM5gzY6/eI1bkDduCYgAMvyMuuNCE6v70h2r2Qlk9nOJwKAvb5z6duD+ArAhJO9VEcU67hYHVq1TutOZWMQ3ybMstLAd8GKJgbN7YsrOTAhMSrdvQLGIxgVxjtiWGApBDzea4r0YAdXAk8FD0WoKjBfMckCynJJv97XzWzpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767602745; c=relaxed/simple;
	bh=SMIJvydny/1uz4YEBDY/8s1j8oA5CTec59Q/8FlToeU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KA4WYqHnxPvPsxyboCoITQdc9ildaavvmTKCj2otH1ArB3XFmSMhwj5+UJgW4cEONcohna4T/xw1DvgQJS14UBuY1/E88CX0YuBvolzz0KR29DJZR7jkIPHs4x4JaZ0bsNykNVX5HqVZVEAGTcw15Oi65VLdFDkMOQupA2ezSJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fO9vOUle; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XfQ4Jj0/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6058ZqXU1208136
	for <linux-pci@vger.kernel.org>; Mon, 5 Jan 2026 08:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	owo2knkEHrTGLCudWA55pB2/WZkWvc3MvCzY7Jo38es=; b=fO9vOUledbCU0wOF
	5dLBkiaDrxyuEldtpSh1ch2RzLPu6PfjreRe7ysq84vYmVa5I9mvoHLTZFnrBLVi
	p3gl8Lu7ZE31yGF9KbYX42KPZmei8q+HBSRBc+0ZlNQo9L5JjNbSISYxTA0Gx5MB
	7pezjOoLCz0mL+m1ihr1B1ujbsHsk9r9tI/J0O5sHe1ez/chC3Nt78Li1zWsfZON
	dnOnWlh9UAMaw0/qHqgaoKtmUUF7hjXrgPCPgOOUXUd94O6RuQ9ZzmhTILlJ39QE
	Gb2gKzZKMggoSzvTdbGTg8+R5jEEZTYabl7F0DMbYvLndpFly1wbHwY8ie1iZCUV
	DKR9+g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bev9hbt4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 08:45:43 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7d481452732so26108221b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 00:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767602742; x=1768207542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owo2knkEHrTGLCudWA55pB2/WZkWvc3MvCzY7Jo38es=;
        b=XfQ4Jj0/gDFoXN0Rc8M16mth7cXxb7vCtZdWkpa38qgWoG2Id8raRXI02gpHbl1oDi
         DUs/oOnpZt/oC8oACAPVDsovetahwwHM+NLagGnNiZ7KTeuzUhXXLtgcLAw9u6yWRtlP
         F6yRxo+xbldSCR32xfoGQKHqOHfRNqrh29xp6hxMSonHdgPQU5dZQepRuogiVYEXziW1
         qvDCxzWajmyDd3bebuZ1zw+sdCNLpV/to1k9o21JumDD5bZ+PVkiwWPeCUZuOSpwp567
         4poTtPAaxNFr/69+MWflOPMHWG/lhOovltVDhGU9D02Tx9HAeHnxOss3cLcfcDfLa6HE
         isXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767602742; x=1768207542;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=owo2knkEHrTGLCudWA55pB2/WZkWvc3MvCzY7Jo38es=;
        b=j82R6G9IvoHyehzu9QosB/MUeGHpuG7oIXrPcOi+jR5Bh4xeWut5+XU9ZBv/sNnRAI
         hBahDpORQNU+Y9DDFqGpP0nm8Fe/QZxE0yraHkxukeQCiMfhNCoePOum6XuFckkiiOeN
         2sZjli+KEJhDW6kLyzARFOu/U4MQqL3wyiu5JJ5Ns4W8aOlXtt0lzyoH7ByvwmEDlewc
         iRJWAvOEpkX3fSSloY8GRvknxCHguDbSyI6XK2dsHSpNwSQxtXyHPUn65Duf9ZjYEoWL
         v9YuYY5E8OTclRln/bepUA3QjF2e3se4JP6TX/5aF8O9kGb+siBxIab5KaUv0XHOv/y5
         KshQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvOzIp85ZDoevB5Mfefbr30vujb8fbfWxRxUpLgE/6RYczOyZBK2NsWlIROj26dd8bxL1gdhN4AZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnj01hcpCO+vSNxSzVrmFDNdo11VsTaJIeSzzWk9Z1K7WbeWiv
	u0mYpDuM1eqVSjR+EJO2CUZpXqQhHNHJw7LnlycZcaHKCXmkghfQXRQBAwJhZVlGwMR5dhQx9VG
	zyQOufn11sFwk5Sfi/4vTBTU98xp1nNtZT36AapfnuEkcSDA0x+MpAas3GhyBxRpIh2I1f4Y=
X-Gm-Gg: AY/fxX7GuuSQWeqNLCpn9AUKxla8lhobAQA32M04Xl1+k2pl1Fn/HCT4yOtoqlyEMfa
	d26qsqRpSEzbgSnxCKYcUlU7jwuQ9YmOzCDUlVazUt/GFCS48w4i3wVJRDmKwyAlzTZnrUJCuk2
	mmqrRinsERuziUYWee/cdEeze1jJrWkaNc+wcyfHo1mgR9LV/KaBLh7ri6O2s86v0ZTZE9XCZH/
	fO3KQlzwYW+JXqu1I2tzmLf1tKPsRkFTf6GKjrCUmXqsLDKOZW1X3aoPJkBtmWooZNMGBNRnEYk
	swEJdlIT6vurmXrIJRoUjbfT9foo/WfP2jQC5C2VQ2k9vV82565SfLI1EWV0o0Rs1dWmftqWiWY
	jbaMP2SBZSA==
X-Received: by 2002:a05:6a20:3d05:b0:35e:3cac:858c with SMTP id adf61e73a8af0-376a8ac34f9mr46386483637.33.1767602741963;
        Mon, 05 Jan 2026 00:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMvBhc0ZbR6k0FaY78RVr2rQjEFNd2W/FOAOP1PoRx5xHv1FpN6/pgW2Pttoo0pZc29JnwuQ==
X-Received: by 2002:a05:6a20:3d05:b0:35e:3cac:858c with SMTP id adf61e73a8af0-376a8ac34f9mr46386462637.33.1767602741374;
        Mon, 05 Jan 2026 00:45:41 -0800 (PST)
Received: from [192.168.1.102] ([120.56.194.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7ca0b587sm41399110a12.33.2026.01.05.00.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 00:45:40 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251217-dt-bindings-pci-qcom-v2-0-873721599754@oss.qualcomm.com>
References: <20251217-dt-bindings-pci-qcom-v2-0-873721599754@oss.qualcomm.com>
Subject: Re: [PATCH v2 00/12] dt-bindings: PCI: qcom: Move remaining
 devices to dedicated schema
Message-Id: <176760273771.8418.10713849546494908131.b4-ty@kernel.org>
Date: Mon, 05 Jan 2026 14:15:37 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA3NyBTYWx0ZWRfX9Snrn9cGHY+x
 WgPTnOBQk+xbnqrmZpdTbmec73BZWzSdMn98h5LGo6+U9/0UdTg4hLml9vTojlRhYEcE7ZP0uwv
 PuE5Z1+zgSWeqLCnDlXsSQrBiQxwRXhfxOIPVKYgt4zQeP7a4E4VgdM06XvGhhBTtjVS9ygB9m/
 GIbPHleImOb+OOq/+wzqRDarpj9A7CoEZg2MuVOEK9lUXnooI+TTibaYApdjZomuvZsbkJkgv15
 MEP3vWXxMzVTVU+P1x1d6ZEAdJA8tiLKa+MtLCwmFRUi24yBI9n3HvT4JRrQWGu7orUp9P9ILtX
 BTWX9YIMMG5+Pv0t+zQ5QSUhJ3x5WH9zCPXSjPEX679KcCjC/YrOYduSL68gTHmsIPWQrm/Rjmq
 15RtXfYm32FqN/lb1vKH6hVas+scRN6AtVr4M7giSLRwHf229mnC3pV+JmzR7MU8grvgFJyqduX
 z8XLaXN7PCh6csgwqBw==
X-Proofpoint-GUID: gkb7AWHpKb802smTlcAXffypv9tRLTlD
X-Authority-Analysis: v=2.4 cv=RrbI7SmK c=1 sm=1 tr=0 ts=695b7a37 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=3dEILRYKsVIWdVk4w2Qziw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bC-a23v3AAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
 a=6q_225CX-kZnqSqlAqYA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gkb7AWHpKb802smTlcAXffypv9tRLTlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050077


On Wed, 17 Dec 2025 17:19:06 +0100, Krzysztof Kozlowski wrote:
> Changes in v2:
> - Rebase - Mani's email address changed, but I think I used the proper
>   @kernel.org one.
> - Add Rb tags
> - Link to v1: https://patch.msgid.link/20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org
> 
> Some time ago I already moved several devices from qcom,pcie.yaml
> binding to a dedicated binding files for easier reviewing and
> maintenance.
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: PCI: qcom,pcie-sm8150: Merge SC8180x into SM8150
        commit: b73d6672ebc1e3a52b67585f28daca0d2f5bb4f2
[02/12] dt-bindings: PCI: qcom,pcie-sdx55: Move SDX55 to dedicated schema
        commit: c86e1f39f6e4c8425c5b55f276615ae16b5ac57f
[03/12] dt-bindings: PCI: qcom,pcie-sdm845: Move SDM845 to dedicated schema
        commit: c80dc8121d3af8f33413bb0f9ed9e81e2c576e1a
[04/12] dt-bindings: PCI: qcom,pcie-qcs404: Move QCS404 to dedicated schema
        commit: 78aa7d0d9be697409207309013051d080c243421
[05/12] dt-bindings: PCI: qcom,pcie-ipq5018: Move IPQ5018 to dedicated schema
        commit: 7366e19379c75add8ac407439bf9ee8473cab7b5
[06/12] dt-bindings: PCI: qcom,pcie-ipq6018: Move IPQ6018 and IPQ8074 Gen3 to dedicated schema
        commit: 06f4ac1f7673632eaba82d04e578ebb9b783e96b
[07/12] dt-bindings: PCI: qcom,pcie-ipq8074: Move IPQ8074 to dedicated schema
        commit: edf1701c86c91175c0b978d50cfda418516d8d43
[08/12] dt-bindings: PCI: qcom,pcie-ipq4019: Move IPQ4019 to dedicated schema
        commit: 769f6826d5ad8baef1238b10cc97a7b0f678ba43
[09/12] dt-bindings: PCI: qcom,pcie-ipq9574: Move IPQ9574 to dedicated schema
        commit: 5e8bf1c1d5b7f1129148d537afc8feb9c9f883a1
[10/12] dt-bindings: PCI: qcom,pcie-apq8064: Move APQ8064 to dedicated schema
        commit: b673d06ea8449db084cabfee2844f17b6f98f22c
[11/12] dt-bindings: PCI: qcom,pcie-msm8996: Move MSM8996 to dedicated schema
        commit: 0eaa8d1c36f032d6023af96cd84e8b2ece0d6922
[12/12] dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084 to dedicated schema
        commit: 72b39430284fc4a7a960133b70137c24fed63b74

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


