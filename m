Return-Path: <linux-pci+bounces-34260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EAB2BB9D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 10:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F12A4E4195
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 08:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB44311596;
	Tue, 19 Aug 2025 08:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HNmegieV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5C32E229E
	for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 08:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591544; cv=none; b=LJOCY6rR9HAH5btHVUw5sQ5B96dspiX+/NQ2oO2mjN/3qogg2HldKM9ae2aWQv2q1Q9sSX8l+xeyJsT1DOZ9mAZLxDi4srRlQLmPQimeyauEzZiYcukLaEwfvfhvSgZSN3w7xGzKji8EZDLkoEQyw6Igq7ScQHJfhqy9QcxVK24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591544; c=relaxed/simple;
	bh=7mdmCI3pE7SRxl1wlksDJT3J22O8ixrwa/mzwPyZYyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQ2w3ZU0gh7zZaD5LCv5lo/sGz4dH3g+DF3jmhUa7LOOefZ20TlVxxw/BlC66rUopQhHUlXybMb8Ip/YwiyWnKZm9lgAfi0x0pn00sa4Ff/ryqJJ6/oIEU/HqIUu+VYbndUbocBbDlMJ1fBXZnWrNq7rsFu4nFslStC20Re9QeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HNmegieV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-244581cc971so59032575ad.2
        for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2025 01:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755591542; x=1756196342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qTeQV7lwJJxjZljBmKtx6Yk8mSFRaLi85Z6cMQKmB0g=;
        b=HNmegieVJm8NlXlZsLOJVpsIhuX1qgcx5wsodofvTThCtdinCcBam4JehhVzwRxwoN
         afqNc3+3MV0HaEm1n4iLqlCROYSl3tjoY/Nt3J/Smxs79Fd0M1u6rfjZN08kaDeeGO0/
         GWBQ31SKGws8ttbkGlB7MXz5m2eK82g48Nu/aP/WMxmviAjTzQWAsT4hhD8bonNarh5B
         xSCfkGwodeArXbxxGwVPYYFKMEjINlXHrWkf+dnNDctCO6gC9+gI4/EqN/CMNC+628S6
         6QEjXb2hrc3fMyjxS/udxkDL3sxtjmU5trzfryZ9pfj9F2IGQmFYqG7GdqG7vi4bsEs8
         UebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755591542; x=1756196342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qTeQV7lwJJxjZljBmKtx6Yk8mSFRaLi85Z6cMQKmB0g=;
        b=ni+iZewT5tsgBrNtJ0N60GCRwfSGMZ0FnzBR1Lo3xtL2lIboX6gQdNpwrRhGFnW68m
         0Krhu1RbYoPxem2mMlGjJzxneuA7dW9ZI5o19W+rarmwM0T7PN0XyzuRx9LXRzjJxpKY
         2Rjk/XDecYknV9nBvUHl3EdCmVYk4Z/nSwbPEtJhROGbplwKcHTiYMJWP7/LG80DWhSN
         yAUk4cdE5A/9O2JYwVvItCZPtIg9uS0oqJhH1bfIzwH0ATS+Sc0y6AkZ+klXQp5isZzB
         p6T53NhxF77WY4WncBzIhWwGi59Fy6GCyoqKeJzDyELH6gl5hrMkhwI3q+MXMuUxLfKu
         DnaA==
X-Forwarded-Encrypted: i=1; AJvYcCXl4jqud6HZMDUP3LNfWaDOcEJxphT3TH6zKVFKtUX2efNi0MCs2SINE/vhBqKlRIV9Depww783f0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsP7BbzVsVWai3UjKlgtDMCAOsHA7kFBSvDhnUgLH8PSMVjVEf
	31Se+xgJycaEel6VtZipbGlgGRZzaiNCfPW7ZpQ/3/UGKMr3MbHGP0OHxgDfh3p7QfI=
X-Gm-Gg: ASbGnctqgZu4L3kqpF6NslHfKYiYWtMXXBeVcnt/0RLeotvoymBuEM5KFpZ2PtcOh1J
	6jT3Suk7lahp4Aaq+8P+CGc6alC4yCOgWJiomHpmnfBPBkDtTdajuUGcIskDf2YUm/SpkK2GKgq
	m2KTpWDaLJHVclpcsFhdTwA6nIlMhJevAd/esGrYTUst6f0eP+oqszhCsUWEIl16cHTnVui75al
	N5MS0RTUBif21EnXr1RoNnrqPVmm28Sz7b9y875RzqPTyhxhUOiLT4ThtH8mAb7PhHguGJ/Qoj/
	G45gpIZ+0OeYDQD2Zfyc5wxFjh7s6O2tI00UThjHxMLskW9DsVqOPH2CMOOLC8NoqWsxzcYOmj2
	iuxyrN10h9/rvyiymppB1n0p5
X-Google-Smtp-Source: AGHT+IH7e2rkNmbirPUr5cb6RvIu5W5Vnrp1govzDEs6PM6/amKHuOzA0EBh8ZNtgUjYiTgESR1hqA==
X-Received: by 2002:a17:903:2443:b0:242:8a7:6a6c with SMTP id d9443c01a7336-245e02d7629mr23754105ad.17.1755591542312;
        Tue, 19 Aug 2025 01:19:02 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f71bsm100890425ad.80.2025.08.19.01.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 01:19:01 -0700 (PDT)
Date: Tue, 19 Aug 2025 13:48:59 +0530
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
Subject: Re: [PATCH v3 1/3] OPP: Add support to find OPP for a set of keys
Message-ID: <20250819081859.kz7c27d6c77oy2gv@vireshk-i7>
References: <20250819-opp_pcie-v3-0-f8bd7e05ce41@oss.qualcomm.com>
 <20250819-opp_pcie-v3-1-f8bd7e05ce41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819-opp_pcie-v3-1-f8bd7e05ce41@oss.qualcomm.com>

On 19-08-25, 11:04, Krishna Chaitanya Chundru wrote:
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index edbd60501cf00dfd1957f7d19b228d1c61bbbdcc..ce359a3d444b0b7099cdd2421ab1019963d05d9f 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -461,6 +461,15 @@ int dev_pm_opp_get_opp_count(struct device *dev)
>  EXPORT_SYMBOL_GPL(dev_pm_opp_get_opp_count);
>  
>  /* Helpers to read keys */
> +static unsigned long _read_opp_key(struct dev_pm_opp *opp, int index, struct dev_pm_opp_key *key)

Move this to the end of the list, after _read_bw() i.e.

> +{
> +	key->bandwidth = opp->bandwidth ? opp->bandwidth[index].peak : 0;
> +	key->freq = opp->rates[index];
> +	key->level = opp->level;
> +
> +	return true;
> +}
> +
>  static unsigned long _read_freq(struct dev_pm_opp *opp, int index)
>  {
>  	return opp->rates[index];
> @@ -488,6 +497,23 @@ static bool _compare_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>  	return false;
>  }
>  
> +static bool _compare_opp_key_exact(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
> +				   struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key)
> +{

And this after _compare_floor().

> +	bool level_match = (opp_key.level == OPP_LEVEL_UNSET ||

Why are we still checking this ? You removed this from freq check but
not level and bandwidth ?

> +			    key.level == OPP_LEVEL_UNSET || opp_key.level == key.level);
> +	bool bw_match = (opp_key.bandwidth == 0 ||
> +			 key.bandwidth == 0 || opp_key.bandwidth == key.bandwidth);
> +	bool freq_match = (key.freq == 0 || opp_key.freq == key.freq);
> +
> +	if (freq_match && level_match && bw_match) {
> +		*opp = temp_opp;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static bool _compare_ceil(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
>  			  unsigned long opp_key, unsigned long key)
>  {
> @@ -541,6 +567,40 @@ static struct dev_pm_opp *_opp_table_find_key(struct opp_table *opp_table,
>  	return opp;
>  }
>  
> +static struct dev_pm_opp *_opp_table_find_opp_key(struct opp_table *opp_table,
> +		struct dev_pm_opp_key *key, int index, bool available,
> +		unsigned long (*read)(struct dev_pm_opp *opp, int index,
> +				      struct dev_pm_opp_key *key),
> +		bool (*compare)(struct dev_pm_opp **opp, struct dev_pm_opp *temp_opp,
> +				struct dev_pm_opp_key opp_key, struct dev_pm_opp_key key),
> +		bool (*assert)(struct opp_table *opp_table, unsigned int index))
> +{
> +	struct dev_pm_opp *temp_opp, *opp = ERR_PTR(-ERANGE);
> +	struct dev_pm_opp_key temp_key;
> +
> +	/* Assert that the requirement is met */
> +	if (assert && !assert(opp_table, index))

Just drop the `assert` check, it isn't optional. Make the same change
in _opp_table_find_key() too in a separate patch if you can.

> +		return ERR_PTR(-EINVAL);
> +
> +	guard(mutex)(&opp_table->lock);
> +
> +	list_for_each_entry(temp_opp, &opp_table->opp_list, node) {
> +		if (temp_opp->available == available) {
> +			read(temp_opp, index, &temp_key);
> +			if (compare(&opp, temp_opp, temp_key, *key))

Update *key and do dev_pm_opp_get() here itself. And same in
_opp_table_find_key().

> +				break;
> +		}
> +	}
> +
> +	/* Increment the reference count of OPP */
> +	if (!IS_ERR(opp)) {
> +		*key = temp_key;
> +		dev_pm_opp_get(opp);
> +	}
> +
> +	return opp;
> +}
> +
>  static struct dev_pm_opp *
>  _find_key(struct device *dev, unsigned long *key, int index, bool available,
>  	  unsigned long (*read)(struct dev_pm_opp *opp, int index),
> @@ -632,6 +692,46 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(dev_pm_opp_find_freq_exact);
>  
> +/**
> + * dev_pm_opp_find_key_exact() - Search for an exact OPP key
> + * @dev:                Device for which the OPP is being searched
> + * @key:                OPP key to match
> + * @available:          true/false - match for available OPP
> + *
> + * Return: Searches for an exact match the OPP key in the OPP table and returns

The `Return` section should only talk about the returned values. The
above line for example should be present as a standalone line before
the `Return` section.

> + * pointer to the  matching opp if found, else returns ERR_PTR  in case of error
> + * and should  be handled using IS_ERR. Error return values can be:
> + * EINVAL:      for bad pointer
> + * ERANGE:      no match found for search
> + * ENODEV:      if device not found in list of registered devices
> + *
> + * Note: available is a modifier for the search. if available=true, then the
> + * match is for exact matching key and is available in the stored OPP
> + * table. if false, the match is for exact key which is not available.
> + *
> + * This provides a mechanism to enable an opp which is not available currently
> + * or the opposite as well.
> + *
> + * The callers are required to call dev_pm_opp_put() for the returned OPP after
> + * use.

There are various minor issues in the text here, like double spaces,
not starting with a capital letter after a full stop, etc. Also put
arguments in `` block, like `available`.

> + */
> +struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
> +					     struct dev_pm_opp_key key,
> +					     bool available)
> +{
> +	struct opp_table *opp_table __free(put_opp_table) = _find_opp_table(dev);
> +
> +	if (IS_ERR(opp_table)) {
> +		dev_err(dev, "%s: OPP table not found (%ld)\n", __func__,
> +			PTR_ERR(opp_table));
> +		return ERR_CAST(opp_table);
> +	}
> +
> +	return _opp_table_find_opp_key(opp_table, &key, 0, available, _read_opp_key,
> +				       _compare_opp_key_exact, assert_single_clk);

Since the only user doesn't use `index` for now, I wonder if that
should be added at all in all these functions.

> +}
> +EXPORT_SYMBOL_GPL(dev_pm_opp_find_key_exact);
> +
>  /**
>   * dev_pm_opp_find_freq_exact_indexed() - Search for an exact freq for the
>   *					 clock corresponding to the index
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index cf477beae4bbede88223566df5f43d85adc5a816..53e02098129d215970d0854b1f8ffaf4499f2bd4 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -98,6 +98,18 @@ struct dev_pm_opp_data {
>  	unsigned long u_volt;
>  };
>  
> +/**
> + * struct dev_pm_opp_key - Key used to identify OPP entries
> + * @freq:       Frequency in Hz
> + * @level:      Performance level associated with the OPP entry
> + * @bandwidth:  Bandwidth associated with the OPP entry

Also mention the NOP value of all these keys, i.e. what the user must
fill them with if that key is not supposed to be matched.

> + */
> +struct dev_pm_opp_key {
> +	unsigned long freq;
> +	unsigned int level;
> +	u32 bandwidth;

Maybe use `bw` here like in other APIs.

> +};
> +
>  #if defined(CONFIG_PM_OPP)
>  
>  struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
> @@ -131,6 +143,10 @@ struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  					      unsigned long freq,
>  					      bool available);
>  
> +struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
> +					     struct dev_pm_opp_key key,
> +					     bool available);
> +
>  struct dev_pm_opp *
>  dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
>  				   u32 index, bool available);
> @@ -289,6 +305,13 @@ static inline struct dev_pm_opp *dev_pm_opp_find_freq_exact(struct device *dev,
>  	return ERR_PTR(-EOPNOTSUPP);
>  }
>  
> +static inline struct dev_pm_opp *dev_pm_opp_find_key_exact(struct device *dev,
> +							   struct dev_pm_opp_key key,
> +							   bool available)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
>  static inline struct dev_pm_opp *
>  dev_pm_opp_find_freq_exact_indexed(struct device *dev, unsigned long freq,
>  				   u32 index, bool available)
> 
> -- 
> 2.34.1

-- 
viresh

