Return-Path: <linux-pci+bounces-43936-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0F5CEE9A5
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 13:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA51F3045CF4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABA6312819;
	Fri,  2 Jan 2026 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dU4hS1fc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N1Jr6BY0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C6E313E09
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358153; cv=none; b=YBCkBHQ47TweDgbT4JXk23Xs4BBvz++/CGaynZ3UiqaNbvW0tglyv8UBTqyML/1GA7rEHMlm0GKXZSB5x9B78yYbkyadJ+hr8jflJt/LQ164fzO/88I3llpiNtBCFOrAusH82BmGLxrAwjzKnHfmvczBb5USlz+BwRzDVXxfqTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358153; c=relaxed/simple;
	bh=2vSFBEundxLqzUF0iaxUlKJbfat6WpicJdQSaJWZB+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dh0CRQdHV5phl19y7SwsoBmUzZc0OfwdwcYaSb/Z2NahENfALhXfKADktBb4GVsxGDEYpiXMhCyhNAUCGy/Hm9cIEhPGNQPjhfXOMqbT5NlNOPJKAfJ9I1MP9krSFVIgEYQxtiXt4oiAZoMOMK7KBV3RLFSsuGjEsUZQDD8tLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dU4hS1fc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N1Jr6BY0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 602C02f0314699
	for <linux-pci@vger.kernel.org>; Fri, 2 Jan 2026 12:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QksCvkxz701
	havt6PNPEIVEdb5fJwkj5u5XA8V1I200=; b=dU4hS1fcLRhHmIWtZNnbtgTX7pk
	ZzXVmsO1vjJPhVlHxpLuxYjo3VDgjAMJRobKj2x9eFm7HHsLNyQ6n99rnCUiK2jv
	rql1VmU3DjTqIjckCeQ7tNxZSWpVv5O+NFTkZ+/6Y+M4QnRsq1CAdVPumH7DDk+E
	JznvP8htggNi5Ouu8uFhDMpEHccd99+opAHU2cfKzfjzOZMj/SR5bwSQn8QlB0Z5
	z+v1yoQGh8GZx9JZm+D3guUcD3Ckpww9Us265+5ShxOTD0+vJc6ur6NLnmshOq19
	s9P7HZn9JwRBcA1LiKJQWfjIn9Orb58jcAhnd5fDQLrGlxOc76xQl8ypHKw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bedmxr2qd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 12:49:10 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4f4a5dba954so314064501cf.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 04:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358150; x=1767962950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QksCvkxz701havt6PNPEIVEdb5fJwkj5u5XA8V1I200=;
        b=N1Jr6BY004LJQLqvopvJZ5eWOYjYB4p6vQOM5+JwS9CmA7IinGA1LZfoExaPjSdx+v
         9hK4EwLKvEUGYcKCQcolwTOe1Vn7GHz3YmtXBktn2SZP2WuvoA+/Yz/THxw/ABVu+Okd
         BlS+nQVFvjT0HebiP/XFc7TffRVq6j4nKIMMrzu5gf4y22maSGbARl2TbWDqIKljWRck
         ijkQNpjfrKo4iBrIvZnaf/U4sKt1iohoF5mlnhGpQ2+pFUr41chF40mZrGzFbfO24cIQ
         AGD49sXAiJ3DHNIAk5yEBX20qLHhynqdaxWZ5lTEtwMR7fl0o+H0Q8P2psRNDH1aFvJV
         tcew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358150; x=1767962950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QksCvkxz701havt6PNPEIVEdb5fJwkj5u5XA8V1I200=;
        b=rJ+gNG2LXGx7w9GHO+Qu1aeRvEb4xAtbNCJK3jwjQhS5WF4e9WL+MHeiBFSQOJ9J9q
         rIvM/R1DUY1YbpxJmxmssTtlwxgG2LgbkxMb9xmzPWkM+mLs5dFkKpM8yOyAYk1Uh9w4
         8Bu13n+qkjB7MShaO5EfPBCIvpfWlBPMwYYfXfO6Paw7wjY0myycXnSk7bSt/sEwy+JI
         IBnjoos+mjOlT0N+XXXhB+0rxA0w0hO39JuzKkyg8czFk53CO6ZxufMr0YwWo481JQIY
         ZaUiA2/b1pHy7orcd40QsdOlSMtaUKcwzdRLHhEqRUlrZ2uI+XehaItgLhXPJRxg89Mz
         Vdyg==
X-Forwarded-Encrypted: i=1; AJvYcCVQaaq56vXSAX75CXnWgdBhlpI32uyvIwgVwExVJajE4Q9f2CiFbb8tiZa+EjLL3VNz0wYc7WBYvRw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRliOJHV+3i5lYUjdH+4YW9oRVQPxTi0JssLMegilckhZrDuyU
	sIiWFhiOCFRTMIOin0YCucn09ykuPRAO+A2zKTLGe3DBrdCVfIH+BIcdFBz2Zs23ZbWn96sJfSZ
	k+Y3tz1wR7rm1Glml621IlQryMoDYF4q+o8cnIriMRzeY82K6oR5lUA2jKVdBpx0=
X-Gm-Gg: AY/fxX72VBxiDmxQNRWgMApP8M2jC5JzYpr2dcjKsYHQLMDWs8HBj5/SsbAcXNTddfL
	Jpc+urIf0AMFE5ild29Vmldh6F37JffSE6QT7ATwlXNi1tTcNh3Rp3N+KG31WLvnqeFbiWHH9pX
	hettNwdBX65lcG2HB7uTYajBQ8d6IJAa5ZYRwWTylVhr2v498w7jnJRa8T5/a34LjzgwUWSGVKk
	Z5NBVd4/jiypakPD72PFOzdp2Tzx6Ch+JfjhVQwkHRXReYqcdp/kPgDd0lcAGIxPKJLb0LNuUmH
	/G8QmXGAzLoE75OjO4hKKGdxh0iRiP6vgMjcxvP7AX6mL9hABHeP4Sajx1o6knxNAJNZ0XLYbE7
	SIyWgEIJBq5vJQurSL9lnxH2Trw==
X-Received: by 2002:ac8:5a15:0:b0:4ee:1f09:4c35 with SMTP id d75a77b69052e-4f4abd79a40mr632135101cf.52.1767358149759;
        Fri, 02 Jan 2026 04:49:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFL7+iaxfkh7ST1sRsRYoBVUtv2vCaZZf3cjrB67s/8mxAufKjDkRo2M13zTJGUPOHwVYM98A==
X-Received: by 2002:ac8:5a15:0:b0:4ee:1f09:4c35 with SMTP id d75a77b69052e-4f4abd79a40mr632134871cf.52.1767358149357;
        Fri, 02 Jan 2026 04:49:09 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm84804526f8f.34.2026.01.02.04.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:49:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 3/3] PCI: rpaphp: Simplify with scoped for each OF child loop
Date: Fri,  2 Jan 2026 13:49:03 +0100
Message-ID: <20260102124900.64528-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1128; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=2vSFBEundxLqzUF0iaxUlKJbfat6WpicJdQSaJWZB+I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV76+e1GWQ1mozRhfq+ap3krAimH8FTe2HB1j1
 lznowHd+NqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe+vgAKCRDBN2bmhouD
 18j3D/49kYD6fP1TIJI0EqfcpxR44LRXjhjTjuIrdSKl2LOrzXCofrUqhS4sdhdgOT/Ur6opd9j
 BBH+FXCYkqMZI1ZFRbFjugQZRuJKrg8zyiONGWHryQ7lgSxqT2zDHwIiQ+L8CaDCcVDYs/DP5Zd
 0UlXdn6Lql5eVRemHSBxbvGNAzvclucJe1M4aTF6C/N4e9PhyL+GtgmfoUyBP/wBMegUnDLvrhw
 WdikoYBxWa+cBxtXw5QyX5pfQnndDbVKvTm1Ik63bSfk+o7DnXjWxdMCw3fPaDbr51iM9LwErtN
 nC+E18JUmHnLUq/CneetFJ93QmAqM9jW+OlAMaoTYeAg2to4ONPudWZsmp9Fr4D67FSwOLwSOTg
 jVEI6KZiDfF/VsgGtNrwwgP9p1WVHrOcGA4pNmf9JV+zgYMXpy0Uk0pBtCX9TabbUxSD1rr77xg
 SnJ5ZtD/BlQSgUE3ai9133y84tbVEzmXrK+o+YCM0fw59SQ2XDFDXB7QsMwk3t4qRD8ib3AlL2V
 7vbwcRM+SUwpO1ccJwLBXF88a33pdkxgSeyCnZU/uehlMTZKbLt1nSd66+7TqgAy220ryPGxum1
 2notKTa+Vgl2yTPDLOkA9Xbj5d2m3FDvuF+Ga89FlaPD3FQ5Dh5cx/4CrWZdva4lyo3+k6oo4rR TbU6COInLGlpNzQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GupPO01C c=1 sm=1 tr=0 ts=6957bec6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=d5zWgTKZ4CwGW_Y1MEAA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExMyBTYWx0ZWRfX1gYPLCPDq+QM
 hRtiezV8M+5D+8K86pIN5UJOBdd9UC6dZVB6UKh6xhI7Z/524OXlCkiwAL6lYLafzFQD8Lk/pCq
 QhGdS4w0bqY+o1YyD7MREGY1rCjhEYObHTmaXzbDRgTGflfFmmhZxedDHebynWWLmw/TAJbcQL2
 UptCG5drZ50OMkmiyjRJ88oytGPkAPwzihsD+Ibrl3n0QHHfZRgubfGWhUBhSKKqrNkVehkoHVZ
 rxcakJUF33nLQouoNxmr0+mNjQc6KQyszymHj0PWIMADLv2kB412y+JBoAGsCshj8Vm6g0hpjFM
 DFBOpT9xynyWgHMG8IZ4+aWku1KoSl/dve0zTQwBWxaCiftnDwmgzHzs/CUTE3UpSSQmvd07jGQ
 7zks4kqqysb8MMGIwhX/h3gS0VQYGfOnQzHqi3KJshcpFz/3s/BRZuyT3OyZhr0Bx7sUN5mad6e
 DA74nWsuTDbWAU1aE/Q==
X-Proofpoint-GUID: A8FJ1fLG0pRrFkhRqy52baruypkwZBi7
X-Proofpoint-ORIG-GUID: A8FJ1fLG0pRrFkhRqy52baruypkwZBi7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601020113

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pci/hotplug/rpaphp_slot.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 779eab12e981..dc0e29c4fad3 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -82,7 +82,6 @@ EXPORT_SYMBOL_GPL(rpaphp_deregister_slot);
 int rpaphp_register_slot(struct slot *slot)
 {
 	struct hotplug_slot *php_slot = &slot->hotplug_slot;
-	struct device_node *child;
 	u32 my_index;
 	int retval;
 	int slotno = -1;
@@ -97,11 +96,10 @@ int rpaphp_register_slot(struct slot *slot)
 		return -EAGAIN;
 	}
 
-	for_each_child_of_node(slot->dn, child) {
+	for_each_child_of_node_scoped(slot->dn, child) {
 		retval = of_property_read_u32(child, "ibm,my-drc-index", &my_index);
 		if (my_index == slot->index) {
 			slotno = PCI_SLOT(PCI_DN(child)->devfn);
-			of_node_put(child);
 			break;
 		}
 	}
-- 
2.51.0


