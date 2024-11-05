Return-Path: <linux-pci+bounces-16034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D10FD9BC852
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 09:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8849F1F21E6B
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D01C4A19;
	Tue,  5 Nov 2024 08:50:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF851C1738
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730796628; cv=none; b=m7C6BJmYbie4rESRu9P5BGcjRt0SJUkTuE/9k9e5/iJ1NjQ5JHec10m/E9tI7J+gW2VfYIjra34Jq08eM9HqaX6YJ7N+kh/0k1oEkSb9pt7vwuxniTj7gFiJ6ez5e+HaAFYOxCIiXPOOLeQGBeoc2OdLaZGASjSrJ3ll3MBsprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730796628; c=relaxed/simple;
	bh=Bn3CrCO/VfWHTpy1+EnROqGy7fn0t977hL7h7mx+lDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+9D3TOZgiyszkPbR6Wb5P8HwnCWOCnhtHdoo4JTNE5VSVtbXP12YEbChfcU7nu1pD7KMkj8hYRNUcm7O7pdI8HN2KpYTU6XTfRwkR3MKlLo+NBZb+DvOmOo5X9i3oRhY2CGo52/F5PIa0rAhqhGk79zHdNhGM/6SDT/UHGJ0dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so3732186a12.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Nov 2024 00:50:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730796626; x=1731401426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkHssEsGPvc4IffViF2rKjUbHHrUYXvkLhSgOSPKq6I=;
        b=TRc5GvfijKPn/op1WkayLmQiF0crKGJu9FKVX5CXXMkriYEkUWmncUsFcnsaQfYVXD
         pmGYX+BSoHa9dVF1Znd2Od7GW1iqA9T7J6HzIxD6jQ64ND6f6h7t8jG4zhazs6mJTuBo
         DAW8z0VjbVHZ/FBAfc++Hgx7K8v4RNhEtn7ThoA6hAUpHYe9BetmihGHvsaA+dykiVqp
         71QMtT8jG/pPVi0oWLC/HAV69h/x4Bn9zsTgCNbIdTsgxzAUIFZutBWJrpR8FgUU1sSG
         amdPWb4yFoAQ4ARFTSe83vLA7gmL1itJ6i41wpPiQVtLPbNXMxOwGD+UJcOKZjhj5+QX
         Oq8w==
X-Forwarded-Encrypted: i=1; AJvYcCWAexBINpREpxVh5to2C6XhSFLIVLY5yr5AYOsMSK8PCrHBSxa7tLtnxa/yX386woCTEzldBMksZUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00VdzlkU982qwQOOvz9LAXwwbszdxujY2Elvh5mcoJM6OqCv/
	bpSJSL5ayek6b5HfVCj3gQUFUE6dAe3wn7RsY/J6yuAdPXEuY85xUVkUHBpO
X-Google-Smtp-Source: AGHT+IEbpHyEo+Dm6cs0p4OlNbFnmaV5+H/MveIztSb52syM2IHQgDTg4pFOhNDCkcrf01wV8vESYQ==
X-Received: by 2002:a05:6a21:6da6:b0:1db:ee97:56f with SMTP id adf61e73a8af0-1dbee9705c1mr3401928637.25.1730796626268;
        Tue, 05 Nov 2024 00:50:26 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fbe0c8csm11434305a91.46.2024.11.05.00.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 00:50:25 -0800 (PST)
Date: Tue, 5 Nov 2024 17:50:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: 2564278112@qq.com, manivannan.sadhasivam@linaro.org, kishon@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, Frank.Li@nxp.com,
	dlemoal@kernel.org, jiangwang@kylinos.cn, linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci:endpoint Remove redundant returns
Message-ID: <20241105085023.GA2202146@rocinante>
References: <20241104133500.GD2504924@rocinante>
 <20241104234657.GA1446698@bhelgaas>
 <20241105004311.GB1614659@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105004311.GB1614659@rocinante>

Hello,

[...]
> Tentatively dropped.  I will wait for the author to post the patch again,
> hopefully including the mailing list now.
> 
> Jiang, please resend your patch again adding the mailing list, so we can
> pick it up.

Follow up:

 - https://lore.kernel.org/linux-pci/tencent_F250BEE2A65745A524E2EFE70CF615CA8F06@qq.com

	Krzysztof

