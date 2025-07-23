Return-Path: <linux-pci+bounces-32836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970BFB0F849
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 18:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B996E586BFD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B3A1F4176;
	Wed, 23 Jul 2025 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I3aSSJmg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377661E1DFC
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288829; cv=none; b=Rwn309yN7KrysJa0wBxkMLtzKWhbmrlK12GSpQOWi6zZ4FT7xucdh7szDPApNXq/G4eoe+yi0YQiKd0v9xP51Cpo/MflMPOKBYlzmfgL7tVhRr14RDEghBd1c1byen30OCRqhWF98QDaqv3updw+kGcNTmIhwUbCQlyxwQWbrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288829; c=relaxed/simple;
	bh=zrwVpt/ZnMglqEyuji76XLtZ8HQbsMLj8OaI79Ak3/s=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=c18nRXs/yT6AeYJQfYk5bdjvAqNqDSWXtK3Mlz8i8QOY525UZt3nJta2y5M4goVa+lMfjVkeMe414Q+buI1VXAIKQMiDwMeV98YOHGmBfXGrD5UNRXNfP/0j5tZW/CaOiBbvnGQ5UyHQaGgoWk6BhcvBWNrWdnY8PfZnPgGhwNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I3aSSJmg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N9TAeh001853
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 16:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	asewMPoDa8OP/xKR9tMVu5Ys0bUlKWoneZLys80QK6U=; b=I3aSSJmgcVOlGK8k
	2SqRWBx3GM+FrKlJK64ARHxsYleiMUFUQiDjg9BhFlRLX8i5Dlu82EO8de26iPE1
	oaO5tRrasCmCXrsFy7KmTGiUkr3VILzBZ86mNhTVN7pEaxsxsBqmPyWxFB4XL9dK
	ESpcajABvicNkuSLww2QUEmA6S76NK4V6HF4vNpWS3jlUNjM0D1k3tvIhgoyMp27
	tPfGh+IXQG9hjAQztKaG31nI7yL5rp/yHU7g4beURnWrT/SwxPlUA0EK/N7xZiLM
	XZCGDHRC9+M19yhUlnNwFdYSVqz5CQdFMGfqK8F+1d6IwqXU/UXTkW3e2ga2gcZs
	PGYGcQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 481t6w72gv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 16:40:27 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-704817522b9so900766d6.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 09:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753288825; x=1753893625;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asewMPoDa8OP/xKR9tMVu5Ys0bUlKWoneZLys80QK6U=;
        b=XbnJqFIX/sgVbg+lQKfkeLSoRH/LvPgqdLTHLC+dH7prmMvlVoRWFtjyGUKwxqIC0Y
         afZCUmEYa9CrAcr45MRbHqL3w/elm8Wm7fkX9c/bThHq178c10mEXW0a/PIgltYNG8oq
         qSgNqpxeD2EG9eykK1jazTK7jVue1Ippl2bmbjSc/kn7uAe8IsKrAHS8DHZ3yi3PGLS5
         4p8pDxoDDBmaummdOa8CvMajFzXPQ2PvrWjDwNtMQU22tiljvo3I9P2JYtY3sLLWKCmD
         vdXG+Gmuy3JXjAsv7FnhDJVpOlCUUaEBh+M4ivqXnbggPB5MlJd2U9f1ajRupSMbcAwa
         zHyA==
X-Forwarded-Encrypted: i=1; AJvYcCV1ko9+geXwUw7asGGqrO/Yy6O9pjeZeeGkZhElmr+EMrxbCkCltU/Jh12rbr4ztHoAXvzR28Ntu9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9W+wcoioq0tMvJBEKCU3rtLpD7M8HhR2MXN3l890ckC0Aundf
	61mbzmafsUX6P5+MdMtxyOkdJn5VBkWQdYaFbMZ1U1JlUyu8HD9hRxehJC7xbbGLCultNzWI1nP
	S+sDxKpEU0aQB0UU+2vXd4bYG5l3EedX+J8ZcByp4eMEtKnWuGTqeUsjDiEyYY1WNU6ICdMo=
X-Gm-Gg: ASbGncsoKxRHTMPwgRzstHw511B7hsKO4FKjSRNLZLQTjnU9NqY/7lbOWjDDPA1z9+J
	NnepaHKTqoREXhsWwrHgqeB6XYuBhCHWtMOZRkOXSlTlGRmJlHndjaH8P5rxVXKgYkFNpcUOqjU
	ktTWaXc4ZtB6PO/DLyvTUewnEIamTYj9uNsu+cGOZOnu/ktab+HyQsmI7k/F3mVdpt5XSs2dtw2
	bnBDk1Ix/OXGzRkd2GoYoh6P/IjiEH6ZS/zuwrTyzYQ2+HY/fjUn51d1TwRc8/fSrx6oBvA/gi1
	OjVtYtdLKzA6nx5lkVQVCll1GI+l/jWUv5s=
X-Received: by 2002:a05:6214:2aa2:b0:704:881d:3102 with SMTP id 6a1803df08f44-707007112e2mr46418426d6.12.1753288825547;
        Wed, 23 Jul 2025 09:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8wpQf4uwxEj9EM5lfb3sTkgXtWQrBB6/j4Y74ae9n5U8jJuU6pBy3PedPAaibkrHp47c2iQ==
X-Received: by 2002:a05:6214:2aa2:b0:704:881d:3102 with SMTP id 6a1803df08f44-707007112e2mr46417976d6.12.1753288825056;
        Wed, 23 Jul 2025 09:40:25 -0700 (PDT)
Received: from [192.168.1.17] ([61.2.112.87])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70707ed62e8sm6103776d6.109.2025.07.23.09.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 09:40:24 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Google-Original-From: Manivannan Sadhasivam <mani@kernel.org>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Salah Triki <salah.triki@gmail.com>
In-Reply-To: <aHsgYALHfQbrgq0t@pc>
References: <aHsgYALHfQbrgq0t@pc>
Subject: Re: [PATCH] PCI: mvebu: Use devm_add_action_or_reset()
Message-Id: <175328882109.33917.12360207254850484850.b4-ty@kernel.org>
Date: Wed, 23 Jul 2025 22:10:21 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=SPpCVPvH c=1 sm=1 tr=0 ts=6881107b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=L2vWZV9GmkZVUxua0bORKQ==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=MlpMO9RAmn1aYvgnbukA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDE0NCBTYWx0ZWRfXxLLsBpoTN9rB
 UDfG1Y6UrKAt7LsJmWD9LIQ9EDFaUYYTTXSPicQnuFwuWTFFI2YgmETKbvKZnb0J0StQ2kLgvIX
 SMILHcWgjMwFry/uQ/Ts3hb7fDncpyOaVYQxibWTmux0oiCYu+B/1ICx4jvqIKM3GEDykbcs1iu
 jpLushASAmSKbGnB79sCdj0aYFSkgnHTMQLAYbYAGRjjEXBZOlyAE24C8vJoVhHeVAFZn1q8olH
 ysotOEFvgrsBqC+tGq+3TUdgcTJLTLQhmu7LT4GvClIwGWaENaN01PxtHH/ixFztE5hpkRSAlDJ
 1OAvFIuL1SrfRgA/sEOAaG2TPHCTscuYLcnSn1CdMe2bX9iMu2DhNXjC3BsuxXMPMmi+XuZLgK6
 HLeCQY7lr9AmytW12INTdQI8RhXGlND/SK4CHZiE3XFXH6aKDRx7uYYeRN1b5VlD51KGosTs
X-Proofpoint-ORIG-GUID: TspsSWwapzjlsgMw4p4k3509_9on0ZrF
X-Proofpoint-GUID: TspsSWwapzjlsgMw4p4k3509_9on0ZrF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 mlxlogscore=625 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507230144


On Sat, 19 Jul 2025 05:34:40 +0100, Salah Triki wrote:
> Replace devm_add_action() with devm_add_action_or_reset() to make code
> cleaner.
> 
> 

Applied, thanks!

[1/1] PCI: mvebu: Use devm_add_action_or_reset()
      commit: c79a7ca8fb72a17db03e916438c44d9afc98998f

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


