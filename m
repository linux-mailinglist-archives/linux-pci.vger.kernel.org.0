Return-Path: <linux-pci+bounces-33711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A31B2056B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184F47A55B8
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA2623BCE3;
	Mon, 11 Aug 2025 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eMdIHOtq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B69B2356CB
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908382; cv=none; b=E5LGDCYuq0jT5vylvbZ0lePLL4bHRug/FDMxxlyR93VbbRwSSzwvjKPqnn0L8Sp0rEqSz/v0GHBHqkYnN/MchZQOP5tCvSegU32WzRr1CjfKqdLKpAt9JWtFk2OywWvCUdvf+PEJqvGkpOEZ6IAlFFnnqkdy8jXhyDn/g7NOxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908382; c=relaxed/simple;
	bh=LnEoDpnkoJHU8kW/etIi+d+IHIbHf6VB/4ZcFLdBa/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=OA5iXmjTc7HErnuCzFycg1MVom9cOEnIEEEoeMsPz14GdKb6/nupkX1ad4g38DdO2Ir02dclGBaG31vmuB47Yc2ABcpqnu7LqsmFDDkr17Cyi9xTX62Lurjmf2YVlRDLAMM9vSa37XekVeM9A5Hehrsn6Nrfmefunb7i2J9P3jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eMdIHOtq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dKOF018323
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZnHcb9SoHxXWIKTgE0sy5s0fFPVq4IXyx5zLZaTr1jU=; b=eMdIHOtqd3s4zWYG
	K5aGT3wQhdg/20NBi2POFtCEeyFJcg28eH4R3n317ZAIdmfl8O0ObfPn4E6LsOfU
	LxYwsftdF1bziVqY9mqo+XtlEerhowwiy+chsBRVAOgzpumQ112HeyjQROcU785G
	YKG/Xbl3L+Bes1Q4H+/N5i8046RRVsT8Ewq2/JhJn5rFjSkPHhFgiv9BiEer04ML
	k0qrBnt5wuIyWT92Qji6DDtXpjggYSf2Y03eOVx3F9JsJSRnFtv43MaSCytzEBkz
	usUXgNyIY3SaC8xotUsOP6wb4Q+dJqkTFTtl7tGDsfgtZJvkXqggOpYyepkL9DcI
	2F/V1A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dy3g402q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:33:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400cbd4241so69372645ad.3
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 03:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908379; x=1755513179;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnHcb9SoHxXWIKTgE0sy5s0fFPVq4IXyx5zLZaTr1jU=;
        b=Tq+9cPUshB8yh61BbHT8qcY3yqS5bJLArTa0GuDzO2o3fZ1frTynNaT32pqGINPoU9
         JcNs2GsOWzvSI5pV5HdUhfXtPNlm5i+hFkPByvs/adNs04MNeyBcbHiV0GIpAw4K5CbH
         1WhE3R9wYh196IUnZaeEJdDrqfzo/+NfmwP2+vqz+vXSCS/whf0QX/c1jmG0r2cWiR/i
         EDzDfZXkbiqHCzX/B6XvAj/+Xj1xZnpKRB+4PPtlbisJ3eimK64lSLxL/IxaqYbKCk4L
         x5xU9TWM0g3umaeiZVXomgLVp2ry01F82+D89KNtrVM8F4/EZAkuphRhFxKJapRfYayd
         y75A==
X-Forwarded-Encrypted: i=1; AJvYcCWlhRcLcbR9hZJ4XC1hssvNaVu3W6JjAiOTbVt634hbs/xY6hY4SH41Kj+LvcyNaLSL776YcBvDU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthUNwVP5irMJqLhWITcMwt7JTau9OjntCC1nKog2mvxrGz39+
	T/xbMyuHnHuylAZZh7lfYTq7LwDLEvu2q3JbZG8LEROnH7uOqVr+XROpGp/sLwqycHRBKGz9RPn
	MRiKijYv2onXu7fZDmYosZaEMk/Tp6Bh3UG0r7pa+SJUImbNX4fUU968iJ15ytCY=
X-Gm-Gg: ASbGncvig0f3cYVnO2ZT/E6AqSQCjhNKtesJ0PmZ6p5GCrk5KzdlFUuDSMcp/9VBxtv
	RA7zc1gweWL0GMd9TzGzqtrhNBWwAz/EcxL7Jq5/XfMHYlugnp/ZB//dcou/zN7iaNRloLdEnIs
	s3gi+pBRsCIZW7Y16B9gp0Or6JnqjAKp6Ozk+oPY2+saktR124G6I0mR2q/T1TX1fe7iwz1UYBv
	ftW94DUAX/CpqLQdKTfNjN1zRRyOV0Tqrwmz4R1vYRuRVfprPltM1Q7/hk7DHmqBW70AFOM3Q+v
	f4IOq8OrMw+64J2qaHJ+io3TRkpWyeguvCDHlOsS
X-Received: by 2002:a17:902:da91:b0:234:d292:be7a with SMTP id d9443c01a7336-242c1fdca31mr188037465ad.1.1754908379573;
        Mon, 11 Aug 2025 03:32:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnL8seQl4qJRIS+l3fx3q0zvEkrAxHVu3+GqAQLTm/24/fC5Ue6MHpNqLIu1E1JNvc543A9Q==
X-Received: by 2002:a17:902:da91:b0:234:d292:be7a with SMTP id d9443c01a7336-242c1fdca31mr188037065ad.1.1754908379120;
        Mon, 11 Aug 2025 03:32:59 -0700 (PDT)
Received: from [192.168.68.106] ([36.255.17.227])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89771e2sm270188205ad.88.2025.08.11.03.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:32:58 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
        bhelgaas@google.com, sfr@canb.auug.org.au, qiang.yu@oss.qualcomm.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Wenbin Yao <quic_wenbyao@quicinc.com>
Cc: krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_mrana@quicinc.com, quic_cang@quicinc.com
In-Reply-To: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
References: <20250722091151.1423332-1-quic_wenbyao@quicinc.com>
Subject: Re: (subset) [PATCH v5 0/3] arm64: qcom: x1e80100-qcp: Add power
 supply and sideband signals for PCIe RC
Message-Id: <175490837428.9171.16946610135898864162.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:02:54 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=X4lSKHTe c=1 sm=1 tr=0 ts=6899c6dc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=tivzXH558BYE5qsfyb1zSA==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=idEpX0rf-HM0R3Am6JYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzMSBTYWx0ZWRfXzC1HxQXk81sR
 89EjC/OEpc9HYlX7ozeofeohwU0d+cC8UfkoRsY2+oqjZMTU6XtZPPMZb2s5WITC6WcNYBQlVe7
 H50k8Rmpbaz2MBqjpn8M8zLotnWU2A/1PT8UVKgEIQwzupaVQG3Cz43TRkamp615oi1ObjYtdK/
 k7lRj4KrvYFXYqjhv5meeumA7vNL0o6oQIRK6DbENuJhRz17FqOzHWIPdaGtZncsUZ2GifKgmRa
 JsN2UbB17F04ZSkLv34eAvUGqPKu1n+QaD+0+S/X7jt6hlqPIKqVD4Jrm3vQU38a9isWDgIybDZ
 Q6ArwxljBnM2BDNv27+D5GitBDm3XLwZ8/fhf2drVWb+Gv6yl3/qQRPE0p1Jn0fyOLVUo3YiiZw
 LJWZLNww
X-Proofpoint-GUID: 2z5kk3ZLMJqZUkSQaNQbTini28A1SxCu
X-Proofpoint-ORIG-GUID: 2z5kk3ZLMJqZUkSQaNQbTini28A1SxCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090031


On Tue, 22 Jul 2025 17:11:48 +0800, Wenbin Yao wrote:
> The first patch enables the PCI Power Control driver to control the power
> state of PCI slots. The second patch adds the bus topology of PCIe domain 3
> on x1e80100 platform. The third patch adds perst, wake and clkreq sideband
> signals, and describe the regulators powering the rails of the PCI slots in
> the devicetree for PCIe3 controller and PHY device.
> 
> The patchset has been modified based on comments and suggestions.
> 
> [...]

Applied, thanks!

[1/3] PCI: dwc: enable PCI Power Control Slot driver for QCOM
      commit: add7b05aeeb417c86239e6731a168e6c46b83279

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


