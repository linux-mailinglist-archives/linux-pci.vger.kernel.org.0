Return-Path: <linux-pci+bounces-43555-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD57CD8460
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 07:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 015D530019F8
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 06:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8582FFF80;
	Tue, 23 Dec 2025 06:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VMoyQFo/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O4vERsxe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B42168BD
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766472085; cv=none; b=PnX8DqIKhbnha8jAuB3xodsZEmy92exvgI1FSv3jrR79Au30RQ9tPY+kzqZRJ7S3YYCgWexu8JkWpKzDNDTVPN7oMtwi8ml2E2Tp4xiqYmPvRWaiPpYVs6wFHo9/P/7A9SrZ3miisFwZoNlyFaaMWiU3e1xv97+f32KqqBKAhgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766472085; c=relaxed/simple;
	bh=jQSG42iFOfGSKjeSFUaHSsaVCvHAWfEU23GA874g0OQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nRp9w4qhHB6WsB4lVM8qmWXH65O1froJHUgrNbsbqBe+OjB8n727XeQcbtmLbRg/hDpkKd0vznSFfTRWzQbNYshkpXGq6yAG4v8O0gMkRViLQ3gjwrA703X4jR9qoa4VaoT1qmT5G4lpZvzd+3szAJpi3NVWzurgDPG3DWaLO88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VMoyQFo/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O4vERsxe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BN2XtTt1528928
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 06:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nFHpQ+ZwtLSOipgbW1A7FnCEHJ7AKYLUYz3RyIjedpA=; b=VMoyQFo/F8v7WVMf
	0NnY7OU5tdmzWoMFA1Dc6dz7CIv6sl1Sba1xP+97oqMRsjb+S7esJPWQqjpX1bRu
	5HKp4oeN9wFlpK/3/A2OhLnWP1CCB6kOu46fOT3q0qSesDXAXtZLjzP+5jo8t6LJ
	k17QmjoXAt0Mg9Eex8yhTw+z5MSEfJ8o6GOiOYQNXApWgk8R/0ByVaIbntAWD65Z
	LF1gnGtM6C4FPN+ybmiI0YGaGWEkKQ1Arut6YnAhWyu/Xbxmeh39C7BvJV83kKwc
	iUg9TBqF60yP74B7rPOdtAaafsoSO8JOvH85gSbSqkcvLERrkhDz/btfLYds+2ll
	PC7SGQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b758y2uwa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 23 Dec 2025 06:41:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-34aa1d06456so10515070a91.0
        for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 22:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1766472083; x=1767076883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nFHpQ+ZwtLSOipgbW1A7FnCEHJ7AKYLUYz3RyIjedpA=;
        b=O4vERsxe9ZZ526MH21V7dOaken5kVScQoIR7tDFRlyzh1q99bEN2wCeBgXAFPjN1fG
         FdCBs6CCAAUpXyzhreGslklZ47MhX7VMnLy23XyLCuLkBBTgOUIbaMhXEXKNyqE2O5QN
         5Umtcb8voXz9qgeCoLzpK2WkQN3xiqCANcnUTXBrHjAZgjkQ7pgMDiajE7xeK9R+Ctak
         ZfDUSNK40h28wkWA3WwYr8iPD5/bMG23VKB3lnyudvlbx3iGXFwsu2nyqdmh6BPkarw9
         Xmge4eurmT8ZSvuovxjIyC7uDSSHjYci3Q406ysw0pgj/IxJbO/KgSt3UZ5t7FuA/Oqx
         9JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766472083; x=1767076883;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nFHpQ+ZwtLSOipgbW1A7FnCEHJ7AKYLUYz3RyIjedpA=;
        b=A/39Ob4LZk3AJGYAo5bICLiX7eSOn8OQJ/wMWrh7xttSvnWbotw21cA9DmJMQCmiL7
         gADQJ4rO8OnaNlJRLh9lYRwmC/Gutgx89ofa9zrV0s7vRaWarWdbvPkcSiRZvIaVphEQ
         a/VZhzqdXypUBoYlCH+hO6sgXruKFu5qAAl4+B94/0b2a/QKx7lCIqYBqKsiSBU3EO5w
         /Wg1K8pqnpTF6ii1cofB0yFElpTdirazDN5PuiggnuTvg7ArUQNRJ67B0cTXNoiqLPaa
         7auoKnnq8T6R/S5IuXbE10oL2r/hlUoY8Q3azdpsb5Zms8AClvgC7aC6C/T1d+lAiTmE
         W4JA==
X-Forwarded-Encrypted: i=1; AJvYcCVARguS2TPD4Qw7YwRV8C2+oe36ruDHlG8y+U0PohVigGAK6pBu7Y6IzsNGAxwCppzqsbG2pucgcNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw41W+c82If2BgtNOu4zEfz8/NObWQLTfLHq3iidxHmiVu3s7TW
	3NirHcs9iH26ro6kOtMAARgiKzhv0shlp1a/nfYWZHT9L5e+luBQBudGcSQwO/NQUL9sX4FFLoo
	OThJs9MjaiHnmkgk36OfHBf+faXS7IURmqHOzqN33x8WLV0DNIH9tUobJZ+UpQWQ=
X-Gm-Gg: AY/fxX5r85U9Sbw4GtnIPIUkqrxp+nUuda5nlDUhgWDuNLighiwHVJIMnitFnFG9XrT
	o3d82mzYN4d4mC2R8lNySXtXa359knWouc54v7iyW6e1yffHWtoip+sP7a8jy2ogYtKX0YvzHjC
	9xq9xi9tOkrmFoeS6YpsMH8TmT2sBlopkFoQq/AurtXU+xcZmJCsohm7ba+etrLhTt2Dnv8UyHb
	0vKtdzxXLSs/wI7FGUR9sA2nT3oGzQQEEJkAb5CvIek++MWwdTyTcy3el8hxlFsIq3u1dluaf6z
	HPX1hmUECPnvUxdkbQ19doazeOzh/UyRaljgUbSdzNCYxBGTimjcevtRVh2FHpJXHhJbcrhAy7R
	EKfjaSMXN
X-Received: by 2002:a05:6300:218b:b0:366:58cc:b74e with SMTP id adf61e73a8af0-376aacfbf5bmr12945229637.61.1766472082913;
        Mon, 22 Dec 2025 22:41:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEXUhF61/xGkXM1X+0vUrEXlOJyj6uehv/ClwC4XcVTJt6taDpNGfbbQc7aG6fAh++v15CoVw==
X-Received: by 2002:a05:6300:218b:b0:366:58cc:b74e with SMTP id adf61e73a8af0-376aacfbf5bmr12945213637.61.1766472082434;
        Mon, 22 Dec 2025 22:41:22 -0800 (PST)
Received: from [192.168.1.102] ([120.60.139.28])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c1e7ca0baf3sm11272132a12.34.2025.12.22.22.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 22:41:21 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20251126081718.8239-1-mani@kernel.org>
References: <20251126081718.8239-1-mani@kernel.org>
Subject: Re: [PATCH] PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC
Message-Id: <176647207945.161450.8052515821884695336.b4-ty@kernel.org>
Date: Tue, 23 Dec 2025 12:11:19 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TOdIilla c=1 sm=1 tr=0 ts=694a3993 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=wbxd9xFQoh2bOL7BUxlcyw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=nO0wZtMv79AcQGVKydcA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: mymGNeDI15-0vjcZq2smJkqH8uZSmB16
X-Proofpoint-GUID: mymGNeDI15-0vjcZq2smJkqH8uZSmB16
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDA1NCBTYWx0ZWRfX5k9R2PpNdRoR
 HQACvfwoQj468AvBe0UfFmvlPsr955LRWrWFVUt24yOVUFDgrIl+mL8xMn+bU2MUGv7H3lqCe4Z
 r275KWq3Ss/7CVVe+hMYDbmfq7GZy8BoI4QbrxQYKxh0U38gxGIWslSuwZHDb2q/sKHlHVQ/+P4
 ZLYvVAdc7tN5QWm3KyV7hrQ/QeiQJrSm4gIvZHafu6IG3rCGPWJ7iIEDTUZr4ILE+9Cgb/e0FUt
 2yPsBhA18LGygsL1lxa1EkI+eJvsUZybVGDgOz44LOzLodicZc3W93Ev0YQTaWIkh/K/CDeTPeb
 gdnLj+PG29fy0ZkSjyF1SY4pfKkK2DQ+cfZSevCz8WNfkfBIQbsTo5cWtkFpFvGWKMr0BGklXGF
 l8s2vdnOopvV4R6GaDFUdupLSt19W8JY4ngOHHjJPCuUnzXaulxFOdfnQEcSS386VgHHP2F0T2V
 zIQB3ULs0L6UXGyq1gg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_02,2025-12-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2512230054


On Wed, 26 Nov 2025 13:47:18 +0530, Manivannan Sadhasivam wrote:
> Though I couldn't confirm the ASPM L0s support with the Qcom hardware team,
> bug report from Dmitry suggests that L0s is broken on this legacy SoC.
> Hence, clear the L0s CAP for the Root Ports in this SoC.
> 
> Since qcom_pcie_clear_aspm_l0s() is now used by more than one SoC config,
> call it from qcom_pcie_host_init() instead.
> 
> [...]

Applied, thanks!

[1/1] PCI: qcom: Clear ASPM L0s CAP for MSM8996 SoC
      commit: 91f2fb5fe4735c6c99c000857f2e0bd7ebbddb95

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


