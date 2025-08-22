Return-Path: <linux-pci+bounces-34522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF002B30F89
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6476587801
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 06:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E482E6124;
	Fri, 22 Aug 2025 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MX/sGEZf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D062E610B
	for <linux-pci@vger.kernel.org>; Fri, 22 Aug 2025 06:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755845432; cv=none; b=W04UmNXGvTXCSFTF3NkmgfUUmWQv3Ett/ANhlmorBKoIYQAnD8cYfFzvKitdVpMe9A7k2Da7C0u0uPcIwNgwSTG5anJV4lcYZCSJRLTYGfkqpSvM15f23uSNQstGjfcaSbBk5pFtT95pGc5+81TpYrwr05tX85Q0pgyY0VEym60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755845432; c=relaxed/simple;
	bh=DuqjwUZ0I0wbqeZg4eSLBetmOHd1tcp0S+RZur3J6SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MKHmNMoFaouCOUwwvCTv08OXcyJ5t5YSz/ZX7ASmgQwzPeSDIyn/2Iu94+Pqxxskfz2MovgkejqoxOt/jS8vsMwCFhxYLRXxttO9r4TcYTC3le5i3dLPpRwLtspGdHhUFgs/tA+HrpnUl46LWP9pin6+WhbZVX7ZcwNZEbJx/90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MX/sGEZf; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b476c67c5easo1228318a12.0
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 23:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755845430; x=1756450230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac9oBg+zAj6kXtu216Jjjabie+kjofFUW2rsHnH5Bqk=;
        b=MX/sGEZfNy9iQcvjl7FFBF1vsjt8G6QeSkTRRHFyMssJtFS3fwWqYNAB4hqoi7wnil
         /ePRZXcTc4PPbpNcazpUzo3T9llgN5AXyyG3lo4buW0/UE5HxJxNZqGrgt83KKhCM66V
         1OUrvBF7EwH5HNXZcWer4EGeaVvBZ1NvQXjFDZynTrCEr7M7pYjbQTdMjVBkVDCCEZ42
         o26jdkQnQDDe8RhdGJP0y2ekKfMIvmI/KszLzrmDP02WfHDbC//yl3R0gY1Cf7OAvxsJ
         zuEys1rTKqi8BMyazR8gG7bRZyekxK7kxeWPdUVYEpFhzK7OdhcDcFpSg6GhhSAkbHnm
         uA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755845430; x=1756450230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac9oBg+zAj6kXtu216Jjjabie+kjofFUW2rsHnH5Bqk=;
        b=EUSoJfSD9jrxurY26Zo6NHlkR4kvtghBM08Hjp0N+74anjC7dYWhHP6+NndFTvUrBb
         349H2dh/X30D5J8puj+IcltUmKmWayKRVppnh0F9TkfZuwVCaHFPMCTU65ttVgDNTBFy
         llQIYrTv2zOZBOY44F8qmdGOf/fMrALDSGjNniqTC3Ve5qvuF8+qKjqhO/qt4Zz79gCz
         dK1OOptgImjeMt+V60xNklwmeY/hI3daJP3k9MbxzT7xbCozu4fv+VjC52DmrwQiYS6s
         tUfSdhzSQxLSiMENI5201ehJ1dKJ9UhQox6qG2dpptuZpkw6QClBh02WpsDFdxyVAET9
         K2fw==
X-Forwarded-Encrypted: i=1; AJvYcCVtIBMUN9GxyO43yE9GYCknbnq/phyobwRdUgLi0IbVAhX8YTBOaVyIUvEvq8SwPc362In6soDjs5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/o+5tbSQR/EIb/1vPzPYr6g3wUPpG6guzx24bHjzCMF14KtP
	N/rorqsY2q+aXjNMEUwLtIFMa6tfV05sLwOJ2rBhm4/h3W2XGGAW6YpYuSiB2UzWHWQ=
X-Gm-Gg: ASbGnctjAwNoafT8ryjM/izJ5gZDCmllnBTziXbz4/LEssnSxGozOMc75HbuWwkXfxA
	S9u3sAnsqibhM55ysM/Q+2OC/5kbRRsz5cRXr6tr8d1FakdLGvlwQvTmR+zIRUmO5MjLoSNpjs2
	ByPc2HD+EM6LUGynziqNOGofJTXZ3bbgez3FBQJbn3OnI1mjCU1O9Dpp4dPpnZqr2MmRH1vjb7R
	ix51Qwq84W9uklomJ19gnQ+vQiNqwxFczrzuJcFWRLD0xeQE4xc8bOapKqTIJcNMpMd6tMnM9Or
	0HqHH3h3GQGPkncsUqaSNSJ/g8wAtax2uPr3JuAL83dXO9GA2cLvCrDsqOmHTaJedQf7X/h+1+a
	zsLwOpAwjzt7tSkEZmRTykjMD
X-Google-Smtp-Source: AGHT+IHgwZxe9A1mdJuJEAilKFh6/5WCjKikIYsvxCBNTe/vWqdxRw/EgUKt2pMsNi1wJJYtqOnVBA==
X-Received: by 2002:a17:902:e888:b0:240:4d19:8774 with SMTP id d9443c01a7336-24633d6a31amr23345995ad.24.1755845429661;
        Thu, 21 Aug 2025 23:50:29 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed33df68sm74340735ad.21.2025.08.21.23.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 23:50:29 -0700 (PDT)
Date: Fri, 22 Aug 2025 12:20:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/7] OPP: Add support to find OPP for a set of keys
Message-ID: <20250822065026.2ve2uscdjfismm7v@vireshk-i7>
References: <20250820-opp_pcie-v4-0-273b8944eed0@oss.qualcomm.com>
 <20250820-opp_pcie-v4-1-273b8944eed0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-opp_pcie-v4-1-273b8944eed0@oss.qualcomm.com>

On 20-08-25, 13:58, Krishna Chaitanya Chundru wrote:
> Some clients, such as PCIe, may operate at the same clock frequency
> across different data rates by varying link width. In such cases,
> frequency alone is not sufficient to uniquely identify an OPP.
> To support these scenarios, introduce a new API
> dev_pm_opp_find_key_exact() that allows OPP lookup with different
> set of keys like freq, level & bandwidth.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/opp/core.c     | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_opp.h | 30 ++++++++++++++++
>  2 files changed, 127 insertions(+)

Applied with this diff:

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index a36c3daac39c..bba4f7daff8c 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -476,7 +476,8 @@ static unsigned long _read_bw(struct dev_pm_opp *opp, int index)
        return opp->bandwidth[index].peak;
 }

-static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index, struct dev_pm_opp_key *key)
+static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index,
+                                  struct dev_pm_opp_key *key)
 {
        key->bw = opp->bandwidth ? opp->bandwidth[index].peak : 0;
        key->freq = opp->rates[index];
@@ -518,12 +519,13 @@ static bool _compare_floor(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
        return false;
 }

-static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
-                                  struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
+static bool _compare_opp_key_exact(struct dev_pm_opp **opp,
+               struct dev_pm_opp *temp_opp, struct dev_pm_opp_key *opp_key,
+               struct dev_pm_opp_key *key)
 {
-       bool level_match = (key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
-       bool freq_match = (key.freq == 0 || opp_key.freq == key.freq);
-       bool bw_match = (key.bw == 0 || opp_key.bw == key.bw);
+       bool level_match = (key->level == OPP_LEVEL_UNSET || opp_key->level == key->level);
+       bool freq_match = (key->freq == 0 || opp_key->freq == key->freq);
+       bool bw_match = (key->bw == 0 || opp_key->bw == key->bw);

        if (freq_match && level_match && bw_match) {
                *opp = temp_opp;
@@ -570,7 +572,7 @@ static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
                unsigned long (*read)(struct dev_pm_opp *opp, int index,
                                      struct dev_pm_opp_key *key),
                bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
-                               struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key),
+                               struct dev_pm_opp_key *opp_key, struct dev_pm_opp_key *key),
                bool (*assert)(struct opp_table *opp_table, unsigned int index))
 {
        struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
@@ -585,9 +587,8 @@ static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
        list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
                if (temp_opp->available == available) {
                        read(temp_opp, 0, &temp_key);
-                       if (compare(&opp, temp_opp, temp_key, *key)) {
+                       if (compare(&opp, temp_opp, &temp_key, key)) {
                                /* Increment the reference count of OPP */
-                               *key = temp_key;
                                dev_pm_opp_get(opp);
                                break;
                        }
@@ -689,20 +690,20 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);

 /**
- * dev_pm_opp_find_key_exact() - Search for an exact OPP key
- * @dev:                Device for which the OPP is being searched
- * @key:                OPP key to match
- * @available:          true/false - match for available OPP
+ * dev_pm_opp_find_key_exact() - Search for an OPP with exact key set
+ * @dev:               Device for which the OPP is being searched
+ * @key:               OPP key set to match
+ * @available:         true/false - match for available OPP
  *
- * Search for an exact match the OPP key in the OPP table.
+ * Search for an exact match of the key set in the OPP table.
  *
- * Return: matching *opp, else returns ERR_PTR in case of error and should
- * be using IS_ERR. Error return values can be:
- * EINVAL:      for bad pointer
- * ERANGE:      no match found for search
- * ENODEV:      if device not found in list of registered devices
+ * Return: A matching opp on success, else ERR_PTR in case of error.
+ * Possible error values:
+ * EINVAL:     for bad pointers
+ * ERANGE:     no match found for search
+ * ENODEV:     if device not found in list of registered devices
  *
- * Note: 'available' is a modifier for the search. If 'available'=true,
+ * Note: 'available' is a modifier for the search. If 'available' == true,
  * then the match is for exact matching key and is available in the stored
  * OPP table. If false, the match is for exact key which is not available.
  *
@@ -713,7 +714,7 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
  * use.
  */
 struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
-                                            struct dev_pm_opp_key key,
+                                            struct dev_pm_opp_key *key,
                                             bool available)
 {
        struct opp_table *opp_table __free(put_opp_table) = _find_opp_table(dev);
@@ -724,8 +725,9 @@ struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
                return ERR_CAST(opp_table);
        }

-       return _opp_table_find_opp_key(opp_table, &key, available, _read_opp_key,
-                                      _compare_opp_key_exact, assert_single_clk);
+       return _opp_table_find_opp_key(opp_table, key, available,
+                                      _read_opp_key, _compare_opp_key_exact,
+                                      assert_single_clk);
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_find_key_exact);

diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 5d244bf97489..789406d95e69 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -151,7 +151,7 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
                                              bool available);

 struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
-                                            struct dev_pm_opp_key key,
+                                            struct dev_pm_opp_key *key,
                                             bool available);

 struct dev_pm_opp *
@@ -313,7 +313,7 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
 }

 static inline struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
-                                                          struct dev_pm_opp_key key,
+                                                          struct dev_pm_opp_key *key,
                                                           bool available)
 {
        return ERR_PTR(-EOPNOTSUPP);

-- 
viresh

