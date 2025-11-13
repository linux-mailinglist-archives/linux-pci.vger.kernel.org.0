Return-Path: <linux-pci+bounces-41187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B67C5A320
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 22:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7FBBD4F9BF7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 21:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A3D35957;
	Thu, 13 Nov 2025 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SzejrxMH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2427232277B
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069842; cv=none; b=rZwsDDD/Y/hA1bHNbtVrdKmdaYT/nVN5WITeHchMA383A4271TAp17BNSHA68bbmCVyVgQYpgLcjxwFfncJhe6tUvgLw7fhRRIpewrghetj/k40UtQIL868AQG6qNukaQrEEQSsgUH1XumbSXtYgEPE1QF6t+nX39DE3Vhn9/pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069842; c=relaxed/simple;
	bh=qW11JUEojbvbLlVs9M7WXchyeXDRGME01cs3TXChmx8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0jP70xayWDdscso4BeuGhKdGRhhzhPdTF/uqjU95fpN4Q+WE9vAJmgXwRR76pYtaNv7JIlvQV06jDfqNzp3IqghgXJYFdPKTgYNKJ9rNtfVhAVDNYC3h3FF4ecEppgMNBiHnIDTotoD/G3DPX5qGIa1BDEa4V7y5EN43qiBa9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SzejrxMH; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADKRCRD1894389
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 13:37:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=tBwEk7kuOCSNn1uFY8BH7VKpAmgwo5kIiumW/URoUGU=; b=SzejrxMHO6gu
	5ORwnxvLjNsVPBznXwtsBM2a3zI3uNX3BlVP8QQPYTtQPJXeTI64mT1BCsbpVSLv
	99D0T8+DU2fSKxA+d9vgRZSNdF05X164srEwBs2gFdMrU68ro/wmIEJr0aWxUlRe
	jkQv0VRvPNMkEJeeJvLsP83QCnzcDlm/1buigQ6vh6peDT27JGj0yUO99cYeSCOZ
	OLo+ftGldPxghCEuazsam0wTRvWFORs0pcrVyxgrtZNu9RizJLtxd2DNq7KrXyhk
	jwk2ux+h7BUMgihyUnFVC8Ji4OP9+FVdUCe3bwNzJEMj85+UrOP3rfJpjR5SDmNZ
	PZdToJCeoA==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4adpcq8hwg-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 13:37:20 -0800 (PST)
Received: from twshared24723.01.snb1.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Thu, 13 Nov 2025 21:37:16 +0000
Received: by devbig259.ftw1.facebook.com (Postfix, from userid 664516)
	id 4EA86C146749; Thu, 13 Nov 2025 13:37:14 -0800 (PST)
From: Zhiping Zhang <zhipingz@meta.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Bjorn
 Helgaas <bhelgaas@google.com>, <linux-rdma@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <netdev@vger.kernel.org>,
        Keith Busch
	<kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
        Yishai Hadas
	<yishaih@nvidia.com>
CC: Zhiping Zhang <zhipingz@meta.com>
Subject: [RFC 1/2] Set steering-tag directly for PCIe P2P memory access
Date: Thu, 13 Nov 2025 13:37:11 -0800
Message-ID: <20251113213712.776234-2-zhipingz@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113213712.776234-1-zhipingz@meta.com>
References: <20251113213712.776234-1-zhipingz@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=TcKbdBQh c=1 sm=1 tr=0 ts=69164f90 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=S7gPgYD2AAAA:8 a=VabnemYjAAAA:8
 a=EILTAg3qfoMWCRUG53oA:9 a=1f8SinR9Uz0LDa1zYla5:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: any13eSUmmrl86L1lK8Dj8WV8ZnXwCjt
X-Proofpoint-GUID: any13eSUmmrl86L1lK8Dj8WV8ZnXwCjt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE2OSBTYWx0ZWRfXwDxcZiX0PpiF
 vAXcXdJOFr0u+dUyswsh9oUf+2Qg1Y8vYmub6VUmhgqMZqmZWoCSZLS+mb9WmQLxtGYbJzVu67n
 /jAdrlnw0pd7BtSgoxp+5YD5mrocafHVL2plmpikoaLNnCSaaryiBy3CBhjX97SvNphD55D4t5y
 gr2jTkDMUGEvDTAEoXgd4hrZWW7czdJ29SbxcFiS8qOdEbRm54ZfaLE+JxoUdqg8SkNdjP0gJkY
 ogx1sVVC5bPVY5poSl2MKN4FjjASiSkwgRVlKxWc2s50zviVHOnCUalmH79I2BFcQsI+2rxzPlH
 7MlIf+PuTp5170ReCnn7U19Coj0ngJWKjSVj+KS3HLFdPFz2+jX3FrCmYbrJFYq9bxgBOIsGM0B
 LqxVsAddywT413e9mho4uQa0nIjR7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_05,2025-11-13_02,2025-10-01_01

PCIe: Add a memory type for P2P memory access

The current tph memory type definition applies for CPU use cases. For dev=
ice
memory accessed in the peer-to-peer (P2P) manner, we need another memory
type.

Signed-off-by: Zhiping Zhang <zhipingz@meta.com>
---
 drivers/pci/tph.c       | 4 ++++
 include/linux/pci-tph.h | 4 +++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
index cc64f93709a4..d983c9778c72 100644
--- a/drivers/pci/tph.c
+++ b/drivers/pci/tph.c
@@ -67,6 +67,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_type, =
u8 req_type,
 			if (info->pm_st_valid)
 				return info->pm_st;
 			break;
+		default:
+			return 0;
 		}
 		break;
 	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
@@ -79,6 +81,8 @@ static u16 tph_extract_tag(enum tph_mem_type mem_type, =
u8 req_type,
 			if (info->pm_xst_valid)
 				return info->pm_xst;
 			break;
+		default:
+			return 0;
 		}
 		break;
 	default:
diff --git a/include/linux/pci-tph.h b/include/linux/pci-tph.h
index 9e4e331b1603..b989302b6755 100644
--- a/include/linux/pci-tph.h
+++ b/include/linux/pci-tph.h
@@ -14,10 +14,12 @@
  * depending on the memory type: Volatile Memory or Persistent Memory. W=
hen a
  * caller query about a target's Steering Tag, it must provide the targe=
t's
  * tph_mem_type. ECN link: https://members.pcisig.com/wg/PCI-SIG/documen=
t/15470.
+ * Add a new tph type for PCI peer-to-peer access use case.
  */
 enum tph_mem_type {
 	TPH_MEM_TYPE_VM,	/* volatile memory */
-	TPH_MEM_TYPE_PM		/* persistent memory */
+	TPH_MEM_TYPE_PM,	/* persistent memory */
+	TPH_MEM_TYPE_P2P	/* peer-to-peer accessable memory */
 };
=20
 #ifdef CONFIG_PCIE_TPH
--=20
2.47.3


