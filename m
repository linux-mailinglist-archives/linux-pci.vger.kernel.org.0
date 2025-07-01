Return-Path: <linux-pci+bounces-31141-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93188AEEFD5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973011BC54E1
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 07:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3533B25E479;
	Tue,  1 Jul 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="btcweVMR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341672601
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 07:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751355428; cv=none; b=LKMN06gnH9fAY36afUlNMLiS4nWppEqm+zrsoylUNLQPNIWK6agKpPIeHbG50N/KK45Iwi9sps0wSAUKWG6jEH2h4pPyLBYziRTxJcTmfmHDLhOLRdPfiEmVXVJET0aGRdtLdovfHNJoLqlNg5TsDLHf+u0U/Ks2SPkl7f8KDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751355428; c=relaxed/simple;
	bh=cCndqnCEV0L2x9DQeAD8r7njlV2XxiUC+AhkoZAasQc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NoCkzOIwiXVIpz0Uc6vezarnj61qfGyrDpe8YwdzLRiU0b+4Js37fiRkRMsFyWoLMoLMYmfEzO72gGMqkJpUXKfH3oV1IQTNH35AKpIa8dtCVWtCqTYZMdlWVZl0eOQqml8IaE/w4+rVbhlySX/aVy+isHdNZBc3HqRHi9hYOmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=btcweVMR; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ab112dea41so1516572f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 00:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751355423; x=1751960223; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=84nXSAp/Z1PnLoZAVeblOFLGSiCihYkJz9aJ4vUdZ0A=;
        b=btcweVMRO27TmOsgGr9C54wQCsAJZoYuF/GBsZmdd14UOkzvSl7yBBjAYsxoVbO51W
         VEUDnbU933Hlcahiw01+YgMf/n21GBI8rPvl5Q8yf2UMQ7Cq7Twyf0YYGB25XAEx9XtZ
         pE0jKja2EK5eeSPYLfd8JZneSbrUswcJINkSMxpn6DrZvqaYK0CmgwJzenm06CvAsjJe
         4T4aHzNbw0XfaGG2AgJNV2EF62K1C22lc5mgTk/1+8HBBStxa+I8+Z0e/7dGWu5QEUG2
         vENF+yUWzSBdQLqblyFiKHl4qWnxuEbvyDATX/zGIKC7SqIKK7dOeghwsO0ImQ4JB6dS
         JdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751355423; x=1751960223;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=84nXSAp/Z1PnLoZAVeblOFLGSiCihYkJz9aJ4vUdZ0A=;
        b=BM6eJpWPkTpMb/MTbf8u3o71uea+uAnNcMlYcNOoFiSXY65+WGwdoIeB2Fd+IkbUnx
         3oD0gynl21Lt5/zA78UD69shHTJD03fxIlbOWUxDavXBx7vI6qRJ9p0GJVnskRg/DGvx
         LFZD8+yK4g2d3jw8Z9DcgaWyKvcxIC1/1qXOPrAV7pR6E7CT38w2EAbOINfYZohcTxgL
         Wc/oQuArPBo8cwFOdu/dAUlz9l2iMlT5pZfZGle0tHy3rKsZeW63DVQjWHmSfe/g9wvX
         AbM0mF403ZYdwcTylijjSD1GK/tNajjGHKiqaR5AOy8eyhbBuGo1OGTDHWxWxRZgwgxE
         tgUg==
X-Forwarded-Encrypted: i=1; AJvYcCWove6SMflbXLot451IuQiPHNLdDujUH2epvipnc2NWTVBE54yJMXzSbFEMuTWTDV8IJsT5bPnqp9k=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn/o/CUhS+gkNc+RNlaAjrfja29/DadatEaKAm9INnZ3IE3+rZ
	fmu7LbmlS5vA/kuChvFUVyTVc9cksghVCkTAP00JNrhfe6jrIEsLuYRu8bzAabr0j7A=
X-Gm-Gg: ASbGncue6lECsEx1+HFC7AEZfGV3mhC52MsUtEj8axzKUdQoCqc+hY9VM9PqBI+9Rhy
	1sa5EmXbgdRdaZMEcw9ba03Aag8JfiXPLPXvJpKs4iMZP6bxYIrgJEhrlyUiRRQabQnmBljGZSm
	Cr8OTbP/gf7bIT/Og7yWOWL3P0yaQhvUllYGURpt4BxgEabJIixhg84v1K+UsKyvGtnNtkzgLFZ
	r98vsNW2c4qV9ghFCZ5MCRdQv4Wx0h+uUGVhtzQnww/Ky89r5rKw1P/sluhGrwU4ANeEm7Zon7b
	RlJbQFs85Cgbdh5EbZsScjp6gU/kKbqxtWvkso91CN5lpeTGwqrBb2eBH9hV4g==
X-Google-Smtp-Source: AGHT+IFjJP+l9Owhcenlw9SLs9bvnjDG/zUDl7SGdhqFX4q/YS2+JYr3fDMHgOByMEELdFSvV8KjEQ==
X-Received: by 2002:a05:6000:4009:b0:3a8:2f65:373f with SMTP id ffacd0b85a97d-3aa9fc2002dmr12597509f8f.16.1751355422716;
        Tue, 01 Jul 2025 00:37:02 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:fbe8:19b9:f06d:d64c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538a3fe0efsm154899435e9.24.2025.07.01.00.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:37:02 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,  Frank Li
 <Frank.Li@nxp.com>,  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,
  ntb@lists.linux.dev,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Allow BAR
 assignment via configfs
In-Reply-To: <20250630203842.GA1800194@bhelgaas> (Bjorn Helgaas's message of
	"Mon, 30 Jun 2025 15:38:42 -0500")
References: <20250630203842.GA1800194@bhelgaas>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 01 Jul 2025 09:37:01 +0200
Message-ID: <1jikkce50i.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 30 Jun 2025 at 15:38, Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Tue, Jun 03, 2025 at 07:03:40PM +0200, Jerome Brunet wrote:
>> The current BAR configuration for the PCI vNTB endpoint function allocates
>> BARs in order, which lacks flexibility and does not account for
>> platform-specific quirks. This is problematic on Renesas platforms, where
>> BAR_4 is a fixed 256B region that ends up being used for MW1, despite being
>> better suited for doorbells.
>> 
>> Add new configfs attributes to allow users to specify arbitrary BAR
>> assignments. If no configuration is provided, the driver retains its
>> original behavior of sequential BAR allocation, preserving compatibility
>> with existing userspace setups.
>> 
>> This enables use cases such as assigning BAR_2 for MW1 and using the
>> limited BAR_4 for doorbells on Renesas platforms.
>
> Is there any documentation for how to use this new feature?

Indeed no. Thanks for the reminder.

Section 9.8.2 is no longer relevant with that change, I'll
try to add some explanation there. 

>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 131 ++++++++++++++++++++++++--
>>  1 file changed, 124 insertions(+), 7 deletions(-)
>> 
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> index 2198282a80a40774047502a37f0288ca396bdb0e..7475d87659b1c70aa41b0999eabfa661f4ceed39 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> @@ -73,6 +73,8 @@ enum epf_ntb_bar {
>>  	BAR_MW1,
>>  	BAR_MW2,
>>  	BAR_MW3,
>> +	BAR_MW4,
>> +	VNTB_BAR_NUM,
>>  };
>>  
>>  /*
>> @@ -132,7 +134,7 @@ struct epf_ntb {
>>  	bool linkup;
>>  	u32 spad_size;
>>  
>> -	enum pci_barno epf_ntb_bar[6];
>> +	enum pci_barno epf_ntb_bar[VNTB_BAR_NUM];
>>  
>>  	struct epf_ntb_ctrl *reg;
>>  
>> @@ -654,6 +656,62 @@ static void epf_ntb_epc_destroy(struct epf_ntb *ntb)
>>  	pci_epc_put(ntb->epf->epc);
>>  }
>>  
>> +
>> +/**
>> + * epf_ntb_is_bar_used() - Check if a bar is used in the ntb configuration
>> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>> + * @barno: Checked bar number
>> + *
>> + * Returns: true if used, false if free.
>> + */
>> +static bool epf_ntb_is_bar_used(struct epf_ntb *ntb,
>> +				enum pci_barno barno)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < VNTB_BAR_NUM; i++) {
>> +		if (ntb->epf_ntb_bar[i] == barno)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +/**
>> + * epf_ntb_find_bar() - Assign BAR number when no configuration is provided
>> + * @epc_features: The features provided by the EPC specific to this EPF
>> + * @ntb: NTB device that facilitates communication between HOST and VHOST
>> + * @barno: Bar start index
>> + *
>> + * When the BAR configuration was not provided through the userspace
>> + * configuration, automatically assign BAR as it has been historically
>> + * done by this endpoint function.
>> + *
>> + * Returns: the BAR number found, if any. -1 otherwise
>> + */
>> +static int epf_ntb_find_bar(struct epf_ntb *ntb,
>> +			    const struct pci_epc_features *epc_features,
>> +			    enum epf_ntb_bar bar,
>> +			    enum pci_barno barno)
>> +{
>> +	while (ntb->epf_ntb_bar[bar] < 0) {
>> +		barno = pci_epc_get_next_free_bar(epc_features, barno);
>> +		if (barno < 0)
>> +			break; /* No more BAR available */
>> +
>> +		/*
>> +		 * Verify if the BAR found is not already assigned
>> +		 * through the provided configuration
>> +		 */
>> +		if (!epf_ntb_is_bar_used(ntb, barno))
>> +			ntb->epf_ntb_bar[bar] = barno;
>> +
>> +		barno += 1;
>> +	}
>> +
>> +	return barno;
>> +}
>> +
>>  /**
>>   * epf_ntb_init_epc_bar() - Identify BARs to be used for each of the NTB
>>   * constructs (scratchpad region, doorbell, memorywindow)
>> @@ -676,23 +734,21 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
>>  	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
>>  
>>  	/* These are required BARs which are mandatory for NTB functionality */
>> -	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
>> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
>> +	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++) {
>> +		barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
>>  		if (barno < 0) {
>>  			dev_err(dev, "Fail to get NTB function BAR\n");
>>  			return -EINVAL;
>>  		}
>> -		ntb->epf_ntb_bar[bar] = barno;
>>  	}
>>  
>>  	/* These are optional BARs which don't impact NTB functionality */
>> -	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, barno++, i++) {
>> -		barno = pci_epc_get_next_free_bar(epc_features, barno);
>> +	for (bar = BAR_MW1, i = 1; i < num_mws; bar++, i++) {
>> +		barno = epf_ntb_find_bar(ntb, epc_features, bar, barno);
>>  		if (barno < 0) {
>>  			ntb->num_mws = i;
>>  			dev_dbg(dev, "BAR not available for > MW%d\n", i + 1);
>>  		}
>> -		ntb->epf_ntb_bar[bar] = barno;
>>  	}
>>  
>>  	return 0;
>> @@ -860,6 +916,37 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
>>  	return len;							\
>>  }
>>  
>> +#define EPF_NTB_BAR_R(_name, _id)					\
>> +	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
>> +					      char *page)		\
>> +	{								\
>> +		struct config_group *group = to_config_group(item);	\
>> +		struct epf_ntb *ntb = to_epf_ntb(group);		\
>> +									\
>> +		return sprintf(page, "%d\n", ntb->epf_ntb_bar[_id]);	\
>> +	}
>> +
>> +#define EPF_NTB_BAR_W(_name, _id)					\
>> +	static ssize_t epf_ntb_##_name##_store(struct config_item *item, \
>> +					       const char *page, size_t len) \
>> +	{								\
>> +	struct config_group *group = to_config_group(item);		\
>> +	struct epf_ntb *ntb = to_epf_ntb(group);			\
>> +	int val;							\
>> +	int ret;							\
>> +									\
>> +	ret = kstrtoint(page, 0, &val);					\
>> +	if (ret)							\
>> +		return ret;						\
>> +									\
>> +	if (val < NO_BAR || val > BAR_5)				\
>> +		return -EINVAL;						\
>> +									\
>> +	ntb->epf_ntb_bar[_id] = val;					\
>> +									\
>> +	return len;							\
>> +	}
>> +
>>  static ssize_t epf_ntb_num_mws_store(struct config_item *item,
>>  				     const char *page, size_t len)
>>  {
>> @@ -899,6 +986,18 @@ EPF_NTB_MW_R(mw3)
>>  EPF_NTB_MW_W(mw3)
>>  EPF_NTB_MW_R(mw4)
>>  EPF_NTB_MW_W(mw4)
>> +EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
>> +EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
>> +EPF_NTB_BAR_R(db_bar, BAR_DB)
>> +EPF_NTB_BAR_W(db_bar, BAR_DB)
>> +EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
>> +EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
>> +EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
>> +EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
>> +EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
>> +EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
>> +EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
>> +EPF_NTB_BAR_W(mw4_bar, BAR_MW4)
>>  
>>  CONFIGFS_ATTR(epf_ntb_, spad_count);
>>  CONFIGFS_ATTR(epf_ntb_, db_count);
>> @@ -910,6 +1009,12 @@ CONFIGFS_ATTR(epf_ntb_, mw4);
>>  CONFIGFS_ATTR(epf_ntb_, vbus_number);
>>  CONFIGFS_ATTR(epf_ntb_, vntb_pid);
>>  CONFIGFS_ATTR(epf_ntb_, vntb_vid);
>> +CONFIGFS_ATTR(epf_ntb_, ctrl_bar);
>> +CONFIGFS_ATTR(epf_ntb_, db_bar);
>> +CONFIGFS_ATTR(epf_ntb_, mw1_bar);
>> +CONFIGFS_ATTR(epf_ntb_, mw2_bar);
>> +CONFIGFS_ATTR(epf_ntb_, mw3_bar);
>> +CONFIGFS_ATTR(epf_ntb_, mw4_bar);
>>  
>>  static struct configfs_attribute *epf_ntb_attrs[] = {
>>  	&epf_ntb_attr_spad_count,
>> @@ -922,6 +1027,12 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
>>  	&epf_ntb_attr_vbus_number,
>>  	&epf_ntb_attr_vntb_pid,
>>  	&epf_ntb_attr_vntb_vid,
>> +	&epf_ntb_attr_ctrl_bar,
>> +	&epf_ntb_attr_db_bar,
>> +	&epf_ntb_attr_mw1_bar,
>> +	&epf_ntb_attr_mw2_bar,
>> +	&epf_ntb_attr_mw3_bar,
>> +	&epf_ntb_attr_mw4_bar,
>>  	NULL,
>>  };
>>  
>> @@ -1379,6 +1490,7 @@ static int epf_ntb_probe(struct pci_epf *epf,
>>  {
>>  	struct epf_ntb *ntb;
>>  	struct device *dev;
>> +	int i;
>>  
>>  	dev = &epf->dev;
>>  
>> @@ -1389,6 +1501,11 @@ static int epf_ntb_probe(struct pci_epf *epf,
>>  	epf->header = &epf_ntb_header;
>>  	ntb->epf = epf;
>>  	ntb->vbus_number = 0xff;
>> +
>> +	/* Initially, no bar is assigned */
>> +	for (i = 0; i < VNTB_BAR_NUM; i++)
>> +		ntb->epf_ntb_bar[i] = NO_BAR;
>> +
>>  	epf_set_drvdata(epf, ntb);
>>  
>>  	dev_info(dev, "pci-ep epf driver loaded\n");
>> 
>> -- 
>> 2.47.2
>> 

-- 
Jerome

