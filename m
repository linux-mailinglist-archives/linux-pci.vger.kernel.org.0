Return-Path: <linux-pci+bounces-43935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F49CCEE972
	for <lists+linux-pci@lfdr.de>; Fri, 02 Jan 2026 13:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E83930281A9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jan 2026 12:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF85313E08;
	Fri,  2 Jan 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XV+wnMwo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F2FsVaGA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85023126C4
	for <linux-pci@vger.kernel.org>; Fri,  2 Jan 2026 12:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767358151; cv=none; b=K5fy4r3YTal2i/2hoJqeyD2jrC6QIjkVKmiOO9+bWwhICah3sOIIpSTqDJF+VokpIe10TTYF8QI3ET5OUsMhsmg44Kzb+dV50PEMCJOIAia4mf4Otae4/QNMfbLp7ogDGDteftaWkxtF04lyS++a/lmxpN53+BkjE5lFe6ijMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767358151; c=relaxed/simple;
	bh=EP/MtQj5p6JL4xc2pd12GnTgEgj4Ywj3gHAk3b10BJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQXzsZq3U0MwG22YGyFohJsJD7ugyM/gAOGrBXtoEgfAF+LFqfbQgum5FBiscl6lm/hHR3vFP3P5HZ59EKF3ME3TTXFe4pVxg0xwbeHRG5HZ7m4Mh4woOHzSXo0kb3cOaiYykpFZNddT4bYBHe8Mh7Ts4j6x5+gKTNgArXPsofo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XV+wnMwo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F2FsVaGA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6029WNLV2311079
	for <linux-pci@vger.kernel.org>; Fri, 2 Jan 2026 12:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vjTE26x03Aw
	qvTslfagsJJeuVhEuY8F5fXF0GXew3f0=; b=XV+wnMwoxr/Ib/ravOGomuSzEFp
	WmXMh99S6r4ygpXH7eTK24e/S6jbNbndZhPEoh4PLriJbBdFLNhX1tLpg3/FYTcy
	2f1MjjOxorxsh+sMYSm1BE9bdnpdOYp3vgftxs7xXkCF82u2/i6YqTiCyCd/DEWO
	QxWpt9jtlDMELcorRpPCWH4cAvqcyht5fb5MYWehixPFBmh3bgOZcAieG9nnHwx7
	Iden0TAe8ly+/vhtDlIqkLc6MXmpEpRwPFVawmwgIfXtaoZbaN0EXT0fYMwzezuA
	wl/hVRE2QFRNCfCr+fSPiRjMMzpsRRU2hHS4i/b7mSKZg+rshLtr/zdj6IQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bdsc9t1q1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 12:49:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4ee0193a239so123618001cf.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 04:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767358148; x=1767962948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjTE26x03AwqvTslfagsJJeuVhEuY8F5fXF0GXew3f0=;
        b=F2FsVaGArEwz07P7ShKAocK9qoWzZ2LRo/rgT6xw1b/NZi9elXCebNF4KeanA696d8
         6+Jh2wyG1V90lAO3mFu3iNLeIqLdevKeo0TSGAin2UOsJiAJ8i8GwhLL5zLDNManEein
         wpeQkovKilXPYTD6d0jnmEmMCWUlNw/smNE1piMJw8j9dpvwF7byaSm0x71I/3LRhRFs
         2oKYNox+mgbqKDKbIK4rF8vsJXJiMTrHlurk0h3YXStLkmEGK2aAotF9k7wIxkk0ser3
         muGr7xFmeaSSNC7tj2DfO8aX7IfpbmbfS+eJGMNOCNsj0J5sL30XNV7xnSCNy7RGXAif
         RlFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767358148; x=1767962948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjTE26x03AwqvTslfagsJJeuVhEuY8F5fXF0GXew3f0=;
        b=cyDw7eo2K3q6VvgcKjBXKF3Oe7imH8UDaweIgiYiIfvOGH8hSPglfASHAUprK0oQUr
         IYxfsyWF1BnGo5OMfhTTT5Kq6AEmWUS6/BvIrVWhb9ZdB7qqE4DevXljmyQzLG70tZBf
         Ueff2vl9Kt4lV+2MmMOIZLMKLTCCJ2TVNyJqVQnHbIkI73YsCYUPS4AvjEV9pdd3t4kJ
         xsT0Q791mMvxlWEF5o+eRQBtorw0d9xTi4lPDQAUJkeKVwdq+XzAE23jZNxpW0KC//YL
         TUQKBdMl/R7qrqZMw4Rk698JJBnhno6o4AT8/ORXM/LERIAnovbAta967aZWioNQRxk0
         PE9w==
X-Forwarded-Encrypted: i=1; AJvYcCV4kUtwVGOyovczmKNdprcIUj4L6rL/6Q18hoGUWlxmsdWjddhxS2QdP35mcTNTubjqJQ9mdb1MtLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziDxXZ3T4oMcv5iMAnc1UARK98lUDLx0mMw35cDB3sRia5ywQV
	bXVtxvG3Z4koah8OyNxJ+HKkrvOw7aJDhclXTGI7YJm1Q18LlR9Meu3azje5AQKygStqxDhB/TJ
	/nEXfPB7/hBjoPztdJku+8spBkjRhRfWARJ14NMlkBadpX+l1DySZFv4kR0GBwmE=
X-Gm-Gg: AY/fxX7QfNcmCyqwRusRZ1U0y9pf++iG6Z744rWsn4UYa0sX92f3R/lSzvKaPTWZtD8
	dhKkDFywnqARpWTiFqe67N5zoD/PEc6mmZENJRLEf6Oqiga6ym2yUm9WgKmJf8q7+/E69aMqqhy
	3F9SOjIx+xZigvKrSeUkEHDrEAwZP5j61dFfR3jvGKqZZZsx++8EKYGjxNdqlX/Kp7Bl2zgsno0
	aKgmQ+y/wKUzUb8dCfxAUQyNxcCmuKnHB9nSaiJVwKTkGOkk4Iq6n2RMMp6zpEN8waTezWH3+eb
	OW57UQ+tZJKSvTxJNg+tCp2rGd2FdqlQqbOHXjgNQ9EAl8iykvYgQ6oy/UTy+6wgm13YzljdILD
	ngKCsBm5Eg0xJY6vFfeyN516HAg==
X-Received: by 2002:ac8:6044:0:b0:4f4:c150:7d1c with SMTP id d75a77b69052e-4f4c3ebfe26mr430878111cf.53.1767358148092;
        Fri, 02 Jan 2026 04:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKBazsH5X4TVMYBORJZLb3en+SDf+yLtdGDzkSzGie0Q2NHJUzyJIxfJhQBa1t41nJeqUE+g==
X-Received: by 2002:ac8:6044:0:b0:4f4:c150:7d1c with SMTP id d75a77b69052e-4f4c3ebfe26mr430877881cf.53.1767358147674;
        Fri, 02 Jan 2026 04:49:07 -0800 (PST)
Received: from quoll ([178.197.218.229])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm84804526f8f.34.2026.01.02.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 04:49:07 -0800 (PST)
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
Subject: [PATCH 2/3] PCI: pnv_php: Simplify with scoped for each OF child loop
Date: Fri,  2 Jan 2026 13:49:02 +0100
Message-ID: <20260102124900.64528-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260102124900.64528-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1212; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=EP/MtQj5p6JL4xc2pd12GnTgEgj4Ywj3gHAk3b10BJ8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpV769WyVeXeUs9nZiznyQRex29feWr3vh6I2J+
 GAlypK/zzOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaVe+vQAKCRDBN2bmhouD
 1+ASD/9Bilw5E8KjrZdsekRLJEtn10r+Dy1sg1lurcuQ2ExEnV00xVAoiFkxiEPWLrh7WFhTzH6
 WIjL6h2BMk+/H4YjLx6Nwxdrv9TwjVjEeQdQ9GYU/3r2o2cwzEqxckEFVsXSXdga+h52imdboSI
 oCslonQk+20MxS7q8+1HYoG2zQIWR1EEzJ/7yyVwrLgxfzTssevfdMvicfwKjORPE/4wPdj79Er
 LR6EdBX5uyOla66gb/LjgLG6KyWSwIyQcNUlBCE20Ocdc2kAOrhYDlc8gWW/HGmg8o64xU8IFdP
 er8fJE+g6z7ylyIle9/xo3P6IrtdFQaEItU38JUfy8hqAGmzlSOD5ZHD0d7lQpRC+4cjJa0rnQa
 0t1LLkd+CLxXGI5dXQLNsFlsm7i80KjH8B65D75/JOyhulAiIAFKyNejTeVNBdjL3pplCfbguVb
 iTHZXyhdwuMBeVPwSk5FEZu8mxf6qiwy7CioBM553EJxRYvctbzyCy3bAJciImHywpGIGS64BH1
 M3gAtEr5vTRlywvdHCOeduhmY4vkev6aSpX8nm3bpjoyp6iSQCSaxxqPM1xkeG6hRIt6MG+Grz/
 Hil8lnwGcMH2xCN4qaRzjqwA5xjoMWcNV5PKd3d94YVcG97D7/jz7zEtYYOkiWLFK+QGn1vyURc K89KC2DkQR4aVcQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OgGG0uWmx08eoGjxfztvz2rrlxyn4wSV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTAyMDExMyBTYWx0ZWRfX9ceqzxX+cZU9
 xzcSwY0xDo1Pmx+3KlplAhHtxu6Tzt47NcgLILaiV+4aRVn8fDwWGEYnFqvRHHcGJ9mZkE0sFsF
 NHihvVaHFkvxOn/pxbL8GsViX+jCLvhgMjCff4fYeqbNnjJM8AbdMgeTsufLXweAZeKEpJzWpW7
 Luc4nlGSxz4twA5udMme3SweGxLwDulr72svyTwhIEuW4v5BAWzpvIjcIlNdgFluFY0jP3A/7Ng
 y8N4h0SAN6xHItUs+VXcEwc2Za/g3R2EW3aXawjggy27cbtZEMHoXRMlbL9kPzIwv5iujf68SKN
 IAKfmwy4OysmQ0vsaccL3lxYAm2R4Ev6A0KVBisPnq7ZvT29GYqyFg435uNjQBFBjYgPe5x03xK
 V7yIDL1tsQQPljgjDaPFkhyH8zea/N2NAA+hIO13zSMT5An2YEmrzhbZU4gwokqhLo+HJOnt37h
 oimhP2csCKkNhj9VmaA==
X-Proofpoint-GUID: OgGG0uWmx08eoGjxfztvz2rrlxyn4wSV
X-Authority-Analysis: v=2.4 cv=Hq972kTS c=1 sm=1 tr=0 ts=6957bec5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=Eb9f15NH/cHKzfGOmZSO4Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WsY6cfW8n5MRYgmDw1UA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-02_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601020113

Use scoped for-each loop when iterating over device nodes to make code a
bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/pci/hotplug/pnv_php.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index c5345bff9a55..0d80bee284e0 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -215,24 +215,19 @@ static void pnv_php_reverse_nodes(struct device_node *parent)
 static int pnv_php_populate_changeset(struct of_changeset *ocs,
 				      struct device_node *dn)
 {
-	struct device_node *child;
-	int ret = 0;
+	int ret;
 
-	for_each_child_of_node(dn, child) {
+	for_each_child_of_node_scoped(dn, child) {
 		ret = of_changeset_attach_node(ocs, child);
-		if (ret) {
-			of_node_put(child);
-			break;
-		}
+		if (ret)
+			return ret;
 
 		ret = pnv_php_populate_changeset(ocs, child);
-		if (ret) {
-			of_node_put(child);
-			break;
-		}
+		if (ret)
+			return ret;
 	}
 
-	return ret;
+	return 0;
 }
 
 static void *pnv_php_add_one_pdn(struct device_node *dn, void *data)
-- 
2.51.0


