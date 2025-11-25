Return-Path: <linux-pci+bounces-42042-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B904C85560
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 15:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ABA93B0308
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 14:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43928322C99;
	Tue, 25 Nov 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iiqUOT3O";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Cy2uu31c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC073A95E
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764079893; cv=none; b=gx8utKZQVu5W5rxqbGTmAkiTrQdbTxgvuTt1GgK9kussUaabMx4PGJK0cUwu7hYYm/fhX/zzlugMRhC6/VZSom+LCEhT6rdF8EZTon4P4tvZFokKPv3m5wPmOfiRLz7yIkQJiyKhwKI1s3oMcFRMwmyT98+OvJCPBmweb8dsgD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764079893; c=relaxed/simple;
	bh=dB03BKcfNzMOgS9NihU1KqH6qU/H9VIMtwapRis6Db0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rv8jrjBFlytreRpY2yR97Urx4l68dvi81jXaY3uxcDxJYUmkdw7pwNDUDyheAFMq7N4NCWQXIkmH3MSfMbDRfJHan0ccqV+eXy+OGsNBhP12Q/he1ckwV4uqgYn9EBghG0K2B8v0MkptxOf1HlM++/brn6Ub/5Nbj3rlX+lOiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iiqUOT3O; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Cy2uu31c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP9Zq2B1233477
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 14:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KdtGzIoGcsgehrQYj1xofUWFHq7b2VQbVK64G5NpfMg=; b=iiqUOT3OsAvsfMiI
	eLJntZ1MaBHzYT2msDVKHkBzZoJ/mCg2JwUIWKvOIAud8MV6bp9WGgUfHR0/aBG6
	95dwn3eaC8j/m3w5oPgdHEUT01dgNKxcLUYqC8x1d+LGoY/ck/GUhW6lrJFv/oFa
	jrNZezlxcSGqeUT+FvwIXJHvnebxrpJkcK3WEfrxKJ9EgWgrub6qJ/yeUgi9sqdy
	AAMncwwzwJAI63e78Dho3IMMFEf3C5+4mhL+o/Rtiagi+zOcVB1lC0RQLvp9FEJr
	UAG8dEaV8XakIVPJ5QfaU/a/BLlQ0et4OF5xNGySj7DYii4LKlFt4LnfA+6gnAnn
	HuVlPg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4an0xyjdsg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 14:11:30 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297e1cf9aedso135577235ad.2
        for <linux-pci@vger.kernel.org>; Tue, 25 Nov 2025 06:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764079890; x=1764684690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KdtGzIoGcsgehrQYj1xofUWFHq7b2VQbVK64G5NpfMg=;
        b=Cy2uu31c75Pd3UpNZ43TVQlL54iRd4BtLi1aFhrzvEoP//tYzJr8uNaSRlfdBP237d
         bhzTcGi5DOgv1wmp0q9QGufVarExRh5wCuqG5aatJrCed14rkkZ2XA4kAyCE2CtzYS00
         bRFJ2QXhLI7OiFBWk+3wRvFp2RKmfdbYmnZMObXtXZfFGfPIWQs8hjb0gphPtyu/0U1Z
         x35/r26QjSCRnelwm7ynuJ5ZYNfYx1Gp4OkNYnkX+5jgLy/SopMHxmoYu+RdP8a0BgO7
         kfmcWX58Z9awql9lV4QrE1o1hJfHfpBmZB+4p4tojMkIuRGGVP5hUb+Rf+6rJCOAipzg
         UJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764079890; x=1764684690;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KdtGzIoGcsgehrQYj1xofUWFHq7b2VQbVK64G5NpfMg=;
        b=NkIB8qxbC5+MgK31Gs1FISFlrY5TcGwqWgzewURDNzVuSlTKMWW72J+U37oygE+GHX
         xR37Al9qbti+DYmS7XoeEaTZvxJRo29DUIZIgBQIPdCQZ3Ehy9zcbYJDPw6suPjr7aB4
         fNMHKquUaroX7e8JZLzSR16mvJn04mrVbz1pHhVSiNzYf2kmyHyznNd4Nr8GKqPnsGlW
         7zjmmo7iW2xqF9iTcHa8PAiqdXfnxu1HZ6RKKnciEvdKRXc2qeu5WYdKc+LEvq42EiuW
         Iu1VDvAuu7U9JEPF6dASoYkAKw5PyqsPy/AnggcaNiw89PpUf8Zm1KUBKeprui7Jf1Fp
         1ziQ==
X-Gm-Message-State: AOJu0YxCEzk9+Zx4ZnUnVJTyg4MYtNzgQIF/3PGMJAgEDXhkYXSx/bcl
	iEc1QpFTQaNo73cRq2gzhKjxcw400C7F93X0Ole4L8h+vHavPeBW3027vkCbYtZR1T3KLKKMHqT
	zTPJAkTPzfutO/nJg1pjzxGjeiNoQ6ibYjcywF3bMur+Fvr7gsDbXlmNbNjzwigQ=
X-Gm-Gg: ASbGncuFjPAc7epVJk2dIobMygekzaXoqWnsbPucSX40Chbbb7suZ1H03s9ztumoxkZ
	xui8JHR/2Ru62mc0Fvt6zXNXhtPRJl3S8MsJcPUau6oBLSI25xUBaZsWkEqNmZ0ElYZ4Vy05yLn
	5ERI8eJ2gp3q1KMiCS2zJPuTMMoBM8ZqZadTcfCu3EFJzdkCKMHpVKsK+QX4iOEXo8qxGDIU/+J
	4ERwFXvYZv8GRYb/8VdfWsSUzsrBTLeDpEerTXhDgJkFixXzn0F26qryDNVwf56lxyy7hFwXpnK
	bp61NzPNEZgRen02DI51j1MuisPjxo/lscTGkGDC4idzwlWMH7TcHLEwkXdG2cy3pRVEeEBozWk
	4yGr4Er4l
X-Received: by 2002:a17:903:986:b0:295:1e92:6b6d with SMTP id d9443c01a7336-29b6bf762e2mr179884495ad.46.1764079890262;
        Tue, 25 Nov 2025 06:11:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDdJzjmEfULVH4U40vj7hFWYZbDC9ldO4MPl4fLHvCDnTdfxPW+aFnKkbKvy6S17W0LV0gBg==
X-Received: by 2002:a17:903:986:b0:295:1e92:6b6d with SMTP id d9443c01a7336-29b6bf762e2mr179884025ad.46.1764079889763;
        Tue, 25 Nov 2025 06:11:29 -0800 (PST)
Received: from [192.168.1.2] ([2401:4900:88e8:55c:689:49de:1265:4666])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e558sm171977765ad.55.2025.11.25.06.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:11:29 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>
Cc: Radu Rendec <rrendec@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
In-Reply-To: <20251125102726.865617-1-maz@kernel.org>
References: <20251125102726.865617-1-maz@kernel.org>
Subject: Re: [PATCH v2] PCI: host-generic: Move bridge allocation outside
 of pci_host_common_init()
Message-Id: <176407988578.155590.11732737188227682700.b4-ty@kernel.org>
Date: Tue, 25 Nov 2025 19:41:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=S+bUAYsP c=1 sm=1 tr=0 ts=6925b912 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=M9iB-ojpKhN3dxfJ59YA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDExOCBTYWx0ZWRfX4mtjIaHWwdFP
 E31QWVVnRQOaR0uZFDm1kPm38TiDdhQ0NPsfySWi6JyTfoZlc4eqKbawuG3rGo0Qacx+JhKte+l
 ZdqrfL8UPqlfUJKqdMiVauS7fFyWjA2FWhQHrJcMrhsnh/x18ZMFWZsIwxEe4AOF80psqj3u8pv
 C+paC0W4Hpl6CW3PYq45wikOAEG1eO5VaQBQS51VJyVLKR+Qel3yy/Sxq0aFOh6/ZzvU0zeHqC+
 H/sbZaWKYc3weEm+1zK62Pj8twsChdWvE54LAZsGcbRpXJRXReLsUAabbD4n8oFXHLB+zEvBCFI
 Z2XBZIiQ4s9HDWrk/D+jwB+ZN8d7g02R2SldDbY9asA9610LBQAIgshxnxR+1GjCP1FL6x4r400
 4TTxSyumFVfPwx2pNVFjXmg5IO0jQA==
X-Proofpoint-ORIG-GUID: 1qrUOWwDqUvyoJHFOUkSkAUoriIES5iM
X-Proofpoint-GUID: 1qrUOWwDqUvyoJHFOUkSkAUoriIES5iM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250118


On Tue, 25 Nov 2025 10:27:26 +0000, Marc Zyngier wrote:
> Having the host bridge allocation inside pci_host_common_init() results
> in a lot of complexity in the pcie-apple driver (the only direct user
> of this function outside of core PCI code).
> 
> It forces the allocation of driver-specific tracking structures outside
> of the bridge allocation, which in turn requires it to use inefficient
> data structures to match the bridge and the private structure as needed.
> 
> [...]

Applied, thanks!

[1/1] PCI: host-generic: Move bridge allocation outside of pci_host_common_init()
      commit: b1e24e05e1408602d3414b95031242bbaa72226a

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


