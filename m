Return-Path: <linux-pci+bounces-27777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C73AB825C
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 11:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D717ABCDA
	for <lists+linux-pci@lfdr.de>; Thu, 15 May 2025 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5133295DB8;
	Thu, 15 May 2025 09:19:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C70295DB5
	for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300798; cv=none; b=CFSA825Zoin5P+VPA883r4GONJGYPEKlmDVs/brjGBmVoiZMTTJWLqn2FcfCpL02Th9vrjEy337254w6237aWlBNjJ7jsc/s43bJJEbhgiF6qhgD0qtQ5hqrj0deVZPSo+GMp4ELMy4dOZ9iG5Q3z+ATnU3YfsZSTRpa69a3/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300798; c=relaxed/simple;
	bh=27BgqZply+/JSM8w3Q+eEIN5X9am9OQ8w9Lycn4Lcx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3xmckbfn8+myp4MSQ45wwTMLrSLCc7sOVrQW1eUVsWpIZlcH1BA9+7U760cXGt8nIeLVwp4xbGF7EGLlmKuOlBqcgosnoPbjyiwdng5l8nmmaOWWecNkZnMT2TJc6vZw+YUvf72uxjU1o/k8SNQjt/0fVMPQ8zQqakz8nWb9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-73972a54919so669436b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 15 May 2025 02:19:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747300796; x=1747905596;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sly7kHXqrRGdvJB5iOb5QQcI+fsxg5o/luWWE7Ei/To=;
        b=Q4JrcJHKBmo0nZmziFBTiF7y3Zso6cZBUy9QTszdzr0RXtTSh2WxHXU3DU7ls8GKKN
         ksuGL9G1cayWU0EGkkNmosIl9y5R3d/fgJre6idb94MTdVHAXF5KC0rWsSi/XhT8Ziab
         IX4c4au4ERvSrzUaj6B4c2mu8bOQ5bX2uS/ndG59kpy5B3jQPv/faKfom/H1IJGu9NSD
         iFYKKUChnYlkpz+q+qdLHYL158nSnQlRa1WGHrGUB0K+m+DNtgWWw0MJGy7i5DRNqXK7
         1OHtBuFdg3qpmt87N+ha3oRd5Oujbby5ShPcaYd1/ueHQZQr67Ho4h2CDjGz6g5r1fd+
         vG/g==
X-Forwarded-Encrypted: i=1; AJvYcCVZtpiAvGYg6bgYp4G+ujPoJt/oJNZn3xfdIkwELBr4MGOshfn1Ahk1FuKyfxvax3HkJejt01Iijl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWP7hQPo2h+FpRwJoOcqHHLQGFC1O7S/plowQyQzuRbhC1lQrJ
	3Qpw5qXJUOt23Q10Rl8U04yCwVggewQqMf/T4zlchfAg/F6fiwIaMLn1AODmc6A=
X-Gm-Gg: ASbGnct4E1J7TZhQJ1TwaM8/adjfyQMvFoHqftlxyOrHD1z8MFXucHpo6ZGxkVXKFST
	Ydl49gcHd/vnO/d84hZq268uGyf8jy/TVnPcCOuTkECnQ2IsXQqe1mGBOxKbBWbeomfgGng4ofv
	M6wj/+ISkcut+g+LzcHwVC/Bd38btJEQNFwD89fFTjoe+OG6dcpO+tSbQsS9SfXX3RsH8NSKtLm
	iOUy/o838lUa3aeiti1MAWngEIKXf3sUp+u7GZjfKEBAj2ATrRlfPM4EKzhIKFzAQ3CZRlhZnBg
	BLlzgT3Se4WGGkjgQ8R5QSYWxx7W0LUsyQXP5T0IGbYTvxi0gpLrk9XOxgVOMWjAnt0Zix9V4c6
	J3H1SslukCA==
X-Google-Smtp-Source: AGHT+IFuVEr6BM9jzhK4QkAm9P5QQf8rERAevNQeJYJBnBZfUkBiMmtorh/Gb0R5VbI0wsAM/rbOLw==
X-Received: by 2002:a05:6a20:b40a:b0:1f5:6b36:f57a with SMTP id adf61e73a8af0-215ff1b6a3cmr9009418637.39.1747300796233;
        Thu, 15 May 2025 02:19:56 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a8972asm10649368b3a.157.2025.05.15.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 02:19:55 -0700 (PDT)
Date: Thu, 15 May 2025 18:19:54 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: oe-kbuild@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [pci:ptm-debugfs 1/4] drivers/pci/pcie/ptm.c:275
 context_update_write() error: buffer overflow 'buf' 7 <= 7
Message-ID: <20250515091954.GA1059401@rocinante>
References: <b41c1754-c6b7-4805-9f14-7c643d6c5304@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41c1754-c6b7-4805-9f14-7c643d6c5304@suswa.mountain>

Hello,

[...]
> smatch warnings:
> drivers/pci/pcie/ptm.c:275 context_update_write() error: buffer overflow 'buf' 7 <= 7
> 
> vim +/buf +275 drivers/pci/pcie/ptm.c
> 
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  257  static ssize_t context_update_write(struct file *file, const char __user *ubuf,
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  258  			     size_t count, loff_t *ppos)
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  259  {
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  260  	struct pci_ptm_debugfs *ptm_debugfs = file->private_data;
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  261  	char buf[7];
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  262  	int ret;
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  263  	u8 mode;
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  264  
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  265  	if (!ptm_debugfs->ops->context_update_write)
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  266  		return -EOPNOTSUPP;
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  267  
> 1130deffd29ab2 Manivannan Sadhasivam 2025-05-05  268  	if (count < 1 || count > sizeof(buf))
> 
> Should be >= instead of >.

Done.  Fixed directly on the branch, see:

  https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=ptm-debugfs&id=132833405e61463d47d6badff1b8080b09b5808e

Thank you, Dan!

	Krzysztof

