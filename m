Return-Path: <linux-pci+bounces-34239-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D257EB2B8BC
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 07:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B67BB567BA1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 05:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE925A2B4;
	Tue, 19 Aug 2025 05:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzqZ7Jd9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFF43101C2
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581705; cv=none; b=brM8TjHqL7J/u+M79Md0bRtoeY7DP2H5tIvvfe8bJMsmMTajLne8y3kfCGbNI9AouhNkw+cMyjiiIJgFAQfJiofi1UGQeCJIOCdRVVVpx53Z0apVpmfnGt8CZ0jvCo8b+7aZlRxh+v6SJWE8wx9AvebpJNbNkD0cALoS+0MGNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581705; c=relaxed/simple;
	bh=IGUYBqodeckAvkTwJGXLLcRUT+selbqJcsZemlSFEHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D4lNDeyUq/FxM9Iyk5R2fW6atvNgv5Bo9BPxeajF7ol226diMhT4ykB+tmf+ZcUkZ36WJd3Pl0MdJRWSzav4Qa7YgFTTrKxLQXZeAz0pGvUnlA/YIX2vbAXwbQiwly7eYWDy2A2ZUl4o6b7bKgickmC3BvbSNrlFG5/2zp5xMZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QzqZ7Jd9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57IMUmSQ026772
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oEfaylhhHT3PRMBgt77f7ADF//VSd924MmiZhS+q5SM=; b=QzqZ7Jd9CiM5OKHn
	v42Z08cLcobbNhw5FaKw1jZEJWgE2qfuLP5ZlMHrsfcAyFWgBUMJk6G7bew2ajlo
	yuNC235z9hJ0IGUsZxvoKDJdnxnosVcAso/VT7nEGwHuHCDgwaviPHA5EBS0setz
	b0Go36OXJs63XYpAr3GgwWf5G4WXopDk9g9BC/rMkRjBUkcpMHxbCKhlMdeidDFb
	9v2daUxOe7+GT3n/WXMdFaO5+H/CCATnu9KjY3BBQ5ytZe11YkXmucKjDBknyDKb
	SKTJZ5ByUNU7RivmfhKPHCY4zD/CUA4FWUJZtXjcrtQ4ZJ7dB6a7PH7rekKSnLHA
	UMBbMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj2ufcbp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 05:35:02 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2445820337cso52427205ad.3
        for <linux-pci@vger.kernel.org>; Mon, 18 Aug 2025 22:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581701; x=1756186501;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oEfaylhhHT3PRMBgt77f7ADF//VSd924MmiZhS+q5SM=;
        b=sSJjhpeBaoJXFmLSxezqD6/atQO/9qswq9qAKIk2ZBuzjV4yQkdImMf9mnpywltTYy
         n+Dr+6AHnBWU0eL1GYfuP+c6sgYsfEGIm16c580exBjq+rdqVpNWUNh2oWCoaOBbz+mR
         6igTMjzoBvfYMmzERHLm0kwI/YRkJ4HREDl9yGOcugQanMnzimlb6THoEOGtRqt7LYAl
         5jHWQ1jjf/28KmGiTgr1XnQvikGx2LEZnx57XDd4RxEjy6NmbQKDJZumYs9zR51MO+a7
         Xv/1bwEc78gXbC8kG3/GYGusb6+wK55co7pYx+EJrM2UUbK+uQVoQpXi4kYsDz9a9b6D
         se+A==
X-Forwarded-Encrypted: i=1; AJvYcCVbO/Yj7I75YszO+iWobQTHQ3m+JoSScN60HgmY+snS0tKyEpJhsBSoWnjjm7xOt2dRAusQR9NSKEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykmVxysWe9toEptrNk7YzJsa5H8q+XVOu+J6Uordp/P71Mezid
	h24HtWSFKpYZ0+9UARF+DLoec/aWb+xRlcFYlunWNjCqoucLmir2aamPWOBpc3tMtdMnIJlfb8b
	hsrMoT0R+7dXujn7cj5pEpuTmp4d0GwarlzhOFPj5Qm73Mwx4HZFrKxYeitKMOKo=
X-Gm-Gg: ASbGncueKGkir5VemU2X5XYrlVgzUgGZnYFBMfIAcpM3caRbzh0KLXArUIw5+yMiLQ4
	9S3aOmLsStxKk+acqnofP3v/XUMJfvh3XM+GhPYvUE/v6oBtxU3vjjlIgGk8MKEzvgy7+GZPZvI
	kQU/e/xEEI3DlNSVs8HBrq3eWhUagPRXId/LlcVDAuq1wXJFU0CSio73bNw8odpuXMZ0zah0RjF
	kzR0o1C/coipK10hiFaAZIPVp2iL4x/tEiB6eXaeULhxIxPTLzhMkF3DLjFvPVN9rwKIW58bj9I
	ndC13EtzW6aq7aoKeCPzBA7LgKRhN3/z8door23G8V9xLnTLE/7vujitHGy04GPSxz0zpuGNu/Y
	=
X-Received: by 2002:a17:902:e751:b0:240:9f9:46a0 with SMTP id d9443c01a7336-245e056ad16mr19552725ad.38.1755581701351;
        Mon, 18 Aug 2025 22:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhygomeqN/twCLgtf4rIAeJ3WW/JSlAe0TPIExYym4m+qO/lkisrRXVqSA50IwU9v8z/7NNA==
X-Received: by 2002:a17:902:e751:b0:240:9f9:46a0 with SMTP id d9443c01a7336-245e056ad16mr19552365ad.38.1755581700824;
        Mon, 18 Aug 2025 22:35:00 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f710sm97004785ad.86.2025.08.18.22.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:35:00 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 19 Aug 2025 11:04:42 +0530
Subject: [PATCH v3 1/3] OPP: Add support to find OPP for a set of keys
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-opp_pcie-v3-1-f8bd7e05ce41@oss.qualcomm.com>
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
In-Reply-To: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
To: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755581690; l=7102;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=IGUYBqodeckAvkTwJGXLLcRUT+selbqJcsZemlSFEHs=;
 b=a6zu95us9JDdiwpabmh6OKUCpDnodAcucS+dYmBc/1vKwHkujn/U4oxMiwAFcmwS6YXwLIJ3c
 Op+POgi5A24Bd0WU5OqK0xB/zx2fhJsXe3+dbGfIpjRtxDrpCo9GVfY
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Authority-Analysis: v=2.4 cv=MJ9gmNZl c=1 sm=1 tr=0 ts=68a40d06 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=76l3OPsZB85xAofE:21 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8
 a=Efh3igjAhhwdWKXb3DkA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: Bmake4rxbnNYSGaa1qw4Sz0BW2sDKx12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMSBTYWx0ZWRfX5bKuwPTgZJGL
 WdBYctGnveC40xUL9fM9LTTpObTIAbxR3ua9bPvC/gCMPT1jbhnz8r2DcE18ceSeK3xI9jpv099
 R5yKqBhljAidPvMr+DFfCAzWlN1ktMTQOYuBEZ/Xmnbl6nhvM3X66dvYYRirzWYp3Ef3o6Vto7+
 zYuwx9yy2/EWQbtI8ldebjZBg5aV80F3z8xExvrj+CLRkhNsd3JJoFNRpV5wzcxfnGrh8j0IiIp
 BaLmHeFdTiHF1gJt/xiB3oQoiK2uBmc0zvlU+L6MdX9kra4WTRNR8p+Fluca23Yyi3jz5uAByMq
 Bstk8eRphwerjG1NkkWTSFV/EEpoSrf7Pn5vCatJzjeLhkIXOSLP3OawB+mDEfuZ5m3gcWdJZ52
 FWyzwofx
X-Proofpoint-GUID: Bmake4rxbnNYSGaa1qw4Sz0BW2sDKx12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-19_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160031

Some clients, such as PCIe, may operate at the same clock frequency
across different data rates by varying link width. In such cases,
frequency alone is not sufficient to uniquely identify an OPP.
To support these scenarios, introduce a new API
dev_pm_opp_find_key_exact() that allows OPP lookup with different
set of keys like freq, level & bandwidth.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/opp/core.c     | 100 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pm_opp.h |  23 ++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index edbd60501cf00dfd1957f7d19b228d1c61bbbdcc..ce359a3d444b0b7099cdd2421ab1019963d05d9f 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -461,6 +461,15 @@ int dev_pm_opp_get_opp_count(struct device *dev)
 EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
 
 /* Helpers to read keys */
+static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index, struct dev_pm_opp_key *key)
+{
+	key->bandwidth = opp->bandwidth ? opp->bandwidth[index].peak : 0;
+	key->freq = opp->rates[index];
+	key->level = opp->level;
+
+	return true;
+}
+
 static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
 {
 	return opp->rates[index];
@@ -488,6 +497,23 @@ static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 	return false;
 }
 
+static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
+{
+	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||
+			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
+	bool bw_match = (opp_key.bandwidth == 0 ||
+			 key.bandwidth == 0 || opp_key.bandwidth == key.bandwidth);
+	bool freq_match = (key.freq == 0 || opp_key.freq == key.freq);
+
+	if (freq_match && level_match && bw_match) {
+		*opp = temp_opp;
+		return true;
+	}
+
+	return false;
+}
+
 static bool _compare_ceil(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
 			  unsigned long opp_key, unsigned long key)
 {
@@ -541,6 +567,40 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
 	return opp;
 }
 
+static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
+		struct dev_pm_opp_key *key, int index, bool available,
+		unsigned long (*read)(struct dev_pm_opp *opp, int index,
+				      struct dev_pm_opp_key *key),
+		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
+				struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key),
+		bool (*assert)(struct opp_table *opp_table, unsigned int index))
+{
+	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
+	struct dev_pm_opp_key temp_key;
+
+	/* Assert that the requirement is met */
+	if (assert && !assert(opp_table, index))
+		return ERR_PTR(-EINVAL);
+
+	guard(mutex)(&opp_table->lock);
+
+	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
+		if (temp_opp->available == available) {
+			read(temp_opp, index, &temp_key);
+			if (compare(&opp, temp_opp, temp_key, *key))
+				break;
+		}
+	}
+
+	/* Increment the reference count of OPP */
+	if (!IS_ERR(opp)) {
+		*key = temp_key;
+		dev_pm_opp_get(opp);
+	}
+
+	return opp;
+}
+
 static struct dev_pm_opp *
 _find_key(struct device *dev, unsigned long *key, int index, bool available,
 	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
@@ -632,6 +692,46 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
 
+/**
+ * dev_pm_opp_find_key_exact() - Search for an exact OPP key
+ * @dev:                Device for which the OPP is being searched
+ * @key:                OPP key to match
+ * @available:          true/false - match for available OPP
+ *
+ * Return: Searches for an exact match the OPP key in the OPP table and returns
+ * pointer to the  matching opp if found, else returns ERR_PTR  in case of error
+ * and should  be handled using IS_ERR. Error return values can be:
+ * EINVAL:      for bad pointer
+ * ERANGE:      no match found for search
+ * ENODEV:      if device not found in list of registered devices
+ *
+ * Note: available is a modifier for the search. if available=true, then the
+ * match is for exact matching key and is available in the stored OPP
+ * table. if false, the match is for exact key which is not available.
+ *
+ * This provides a mechanism to enable an opp which is not available currently
+ * or the opposite as well.
+ *
+ * The callers are required to call dev_pm_opp_put() for the returned OPP after
+ * use.
+ */
+struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
+					     struct dev_pm_opp_key key,
+					     bool available)
+{
+	struct opp_table *opp_table __free(put_opp_table) = _find_opp_table(dev);
+
+	if (IS_ERR(opp_table)) {
+		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
+			PTR_ERR(opp_table));
+		return ERR_CAST(opp_table);
+	}
+
+	return _opp_table_find_opp_key(opp_table, &key, 0, available, _read_opp_key,
+				       _compare_opp_key_exact, assert_single_clk);
+}
+EXPORT_SYMBOL_GPL(dev_pm_opp_find_key_exact);
+
 /**
  * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
  *					 clock corresponding to the index
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index cf477beae4bbede88223566df5f43d85adc5a816..53e02098129d215970d0854b1f8ffaf4499f2bd4 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -98,6 +98,18 @@ struct dev_pm_opp_data {
 	unsigned long u_volt;
 };
 
+/**
+ * struct dev_pm_opp_key - Key used to identify OPP entries
+ * @freq:       Frequency in Hz
+ * @level:      Performance level associated with the OPP entry
+ * @bandwidth:  Bandwidth associated with the OPP entry
+ */
+struct dev_pm_opp_key {
+	unsigned long freq;
+	unsigned int level;
+	u32 bandwidth;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
@@ -131,6 +143,10 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 					      unsigned long freq,
 					      bool available);
 
+struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
+					     struct dev_pm_opp_key key,
+					     bool available);
+
 struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available);
@@ -289,6 +305,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 	return ERR_PTR(-EOPNOTSUPP);
 }
 
+static inline struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
+							   struct dev_pm_opp_key key,
+							   bool available)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline struct dev_pm_opp *
 dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
 				   u32 index, bool available)

-- 
2.34.1


