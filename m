Return-Path: <linux-pci+bounces-44611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DFDD19652
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3DC23063E43
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 14:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F248392C27;
	Tue, 13 Jan 2026 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bdC3XqnD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jTNuOO9C"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A619F392C23
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313623; cv=none; b=oaKqhyB48J0vd/z+vLMDXNekSfg4x0XvFTKmVEFvOmQN3ogYG+3zLoobxSdLYTCruDF9ery9w0TbBl+03IkA3CgRV3Ugq7/B++2XP5JoXfxGzhFrb9wU6Io9LZ3E7dQmjFhirJrxY80jMpXqCvlV3Ua7stZLZJAnTPo7qxKwmF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313623; c=relaxed/simple;
	bh=oDqCvR7IsJAmRRTLHjAAa3Hoqe/2MFlmrsbV/ocJMOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kQQDz3UAlzXjufSxtRugkD7B1xmIHsOOseKXkKXkzesIl4NWmLx36gSm2nJFZym5U+SlcGAYi3FZSBkxd+JhDjWLOcvAU1RSq4x3K+p+EUhlBCHvgVr67rqVM3aX8XO/p/qllw7ARO9dnOnhBo6iS4yKPeK7mRLszLZ/Lx94GFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bdC3XqnD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jTNuOO9C; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D7eQwN3299900
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:13:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ndv2n8oUCWT237e8LXBbbygF+JhhCmzXmlYm0mT+iCY=; b=bdC3XqnDnxlCd66I
	m05wz2kOqP/mPTEXnNypBGvl4+h6BoM/mwxyhxSuhmZ/KyCwDNX7LFSee+KPGatr
	vwiAwcR6lIzwwxvfuE1tNgD0gZ0tx9Fg6un62vC1n3AA0oBmEGCjjYIswK+AXhbH
	vWG9+bYRhKFl8XpY8Rd+ZVs199usFTHafK5wSCoHthxkAX5i35PNBOj59WVR5VM5
	ORTRQUnvXgk+zzb4gHhIdSkko79LyjNMWnSBa1gqUgQLE0f1u2YUe0CAnDAgZzI4
	aLTcOj5MkOcQ9QDhr10ILhhfy1LERnKaChI73aIQ2FxxPjrtFt5Fg1QtzrcjuZ0E
	VDY5Ng==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jmb25f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 14:13:40 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c52743b781eso3166586a12.2
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 06:13:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768313619; x=1768918419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndv2n8oUCWT237e8LXBbbygF+JhhCmzXmlYm0mT+iCY=;
        b=jTNuOO9C6q49Vs4M7WJYdb0Cqwq6sogyuYo52L+7+g/fBydziMq8wq+Fiqqf59sAU8
         PlQ9upNmZ+mth0pkiMRhVUFqo7oZeXuwQfyUwey3K84vy6FheyBgg6heDUQlVQMhbmZa
         2bJF6y42UuxIjx9la5j56EIpxJHE6D6ZGa/XKMZv20earpy2howcuhhaKhuKhLeM3a5n
         VlZrmydIC4gC3uSxNJZaGdYA5YidLMzc2BnW0tdwbU5ILwSVT9DEZjXpOjcgIz4u94NT
         xc9xLq4eN8tiaJ5b6rk+1UJaAU4UJ9cYC+elSsFOL/D2DD0rCCAv7ga+0htuv3Ezg1ft
         7W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313619; x=1768918419;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ndv2n8oUCWT237e8LXBbbygF+JhhCmzXmlYm0mT+iCY=;
        b=ROiXw4N4oYWnLkzq6zDDgcYB/VMUYGQjMAuORL2pSMWSfhuG2X8UTq5d+48Eb6xD0J
         Dq7/rQduqNLqmXVRPS0r9r/ZBc1XSCoLoNrqzA3mZ2HDPbCjtY+eBJoVeLf/PNYhsowl
         uzQ/zCDClD+JFb7yuZI4Zlut0Ke0GKQaN8+MUVsaoWbjRDloUNHUtMWNKSNeXQAOi+ng
         AiFeOvb/2rB0tTJEzyRWJyZ3xQbec8IHdOBy22rgBhcPqr8fC3zUGYoxZcm0U+lzESi4
         7LDPfvrnskwECTr8NHfJN5B0z+BMLOAays4VoVzYZfrxGkYkioL9MoPeae4kTLlVvYbx
         9HQg==
X-Gm-Message-State: AOJu0Yws3ogkCqGAfRx4GXcZDlmaUAKwQAouSjQZLZsc3DeLN6EbgiY0
	GGHKqs2s1958jxjkTPM1UwUVV9TyawhEN51vzjL2u6+CwwCxWq0OZ0UyhAWf7vsZqy9bNI/G33U
	g4DktXpq6tVums0OsqbszI0QVwreOUYhSC1DRn4eeb7IJY/TFw/5CDAX4nL9hrWcl5D5PA7I=
X-Gm-Gg: AY/fxX705PH+yRQfsc2+5Zh3GKj1rElxnr3xF0jNmsExdQ0zfvlicWT/8GjdZCxzr8m
	k6JwpY1/T4vSPNNEgrvH17SpNJc+VwsSJuqVLmweSEqV9A9EdRuhvuJYqlMojv/EAWTMdb4WIhA
	VHdJTZJAEkFfs6vxNphRPj+yVbk2ZqeRrOpJ2NC89r5sxr2osz1maRKxp5lZVprPgc0Ss8uDDhp
	SBP7J5dDZ++NDHf6BdM0SgN9zehNRW1mJCSxYeSNr6OKMKp6KQVfL2B1m/GCm85fSxOEta1YAqp
	v+J96BXiD1AYeCqTWyaoo7BB8Zx6cMqpvKmBwjxT9cebncvSWqlWeGYLrsmG750ACB1GtKlKNTR
	+8mQEPWAb
X-Received: by 2002:a05:6a00:369b:b0:81f:528b:c091 with SMTP id d2e1a72fcca58-81f528bc64emr6862548b3a.22.1768313619151;
        Tue, 13 Jan 2026 06:13:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmc6xuC1gIdCjGMj7cp2G8pLlkDwrhLxGdH6YKup6ma/i0cgfS/kKcArYFf4CgBvDRuGZmPA==
X-Received: by 2002:a05:6a00:369b:b0:81f:528b:c091 with SMTP id d2e1a72fcca58-81f528bc64emr6862504b3a.22.1768313618576;
        Tue, 13 Jan 2026 06:13:38 -0800 (PST)
Received: from [192.168.1.102] ([120.60.62.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81c88628633sm15498035b3a.23.2026.01.13.06.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:13:38 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Kevin Xie <kevin.xie@starfivetech.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        E Shattow <e@freeshell.de>, Hal Feng <hal.feng@starfivetech.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251218102149.28062-1-hal.feng@starfivetech.com>
References: <20251218102149.28062-1-hal.feng@starfivetech.com>
Subject: Re: [RESEND v1] PCI: starfive: Use regulator APIs instead of GPIO
 APIs to control the 3V3 power supply of PCIe slots
Message-Id: <176831361429.497576.11439063740783860965.b4-ty@kernel.org>
Date: Tue, 13 Jan 2026 19:43:34 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: DbkVeJGCPpfRpNMr865dQ_VxhYvQgjmX
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=69665314 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=tlgrONNCw2HA119KiuRAjA==:17
 a=UQb8oz5x2ZoWVpge:21 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=W6VN3AnPqya3tQl1NnoA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: DbkVeJGCPpfRpNMr865dQ_VxhYvQgjmX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDExOSBTYWx0ZWRfXz6k6zc7iuLlL
 sHocDdLfB0MB+1PVCV3g1Gf+7U+u0fi7QEyuND1nEDldei12UUN3t1z1lXfSs9ZARmXey49zcvs
 wixbaasyase3blaz3p6UZnivzX/LRw9duKo1KyQAuBC5CZUwmoof/UOjAjdm6GiFjit8fVJ6Z3F
 ppg4ZmjVdp7bbmtUz53EMddedHzW8FJNXDcpGAKhYQsfOPkcSTi7YRC+jMJiXplSaf5XJr+frwf
 H+ifbURA3/273iE5xzScGYsjMS597wDohqUwAZCYiZ0vJJWZ0LhNC4hUI3TFpVj3CPUX1AJHGJ0
 qGRw537jdGKroaIKsKmMdsehay5TjV6rH/5ImXkfHik7DlykgWpgZib9KauMhPnDwlkHJCi/Tx+
 l1ojK3+FWfZzifb1kR9FcDLotSUK3LE2qY9Hp6bumnDDfL1c/wVKtSHEwOwrPuot0EYGhRX+Esy
 zew3sWNFdXcTUzijNaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130119


On Thu, 18 Dec 2025 18:21:49 +0800, Hal Feng wrote:
> The "enable-gpio" property is obtained to control the 3V3 power supply
> of PCIe slots but it is not documented in the dt-bindings and using
> GPIO APIs is not a standard method to control PCIe slot power, so
> use "vpcie3v3-supply" property and regulator APIs to replace them.
> 
> This change will break the DTs which add "enable-gpio" or "enable-gpios"
> property under the node with compatible "starfive,jh7110-pcie".
> Fortunately, there are no such DTs in the upstream mainline, so this
> change has no impact on the upstream mainline.
> If you have used "enable-gpio" or "enable-gpios" property in your
> downstream DTs, please update it with "vpcie3v3-supply" after applying
> this commit.
> 
> [...]

Applied, thanks!

[1/1] PCI: starfive: Use regulator APIs instead of GPIO APIs to control the 3V3 power supply of PCIe slots
      commit: 05a75df4182e301a1b0059606f77b65c74deaa9b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


