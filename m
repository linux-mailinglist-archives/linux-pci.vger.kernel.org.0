Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A62A44EC9A
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 19:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbhKLScG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 13:32:06 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:34586 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhKLScG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Nov 2021 13:32:06 -0500
Received: by mail-wr1-f43.google.com with SMTP id d5so17088018wrc.1
        for <linux-pci@vger.kernel.org>; Fri, 12 Nov 2021 10:29:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0X7ZFyjHx7DQXPwwwt4h6DkQJVRuUiPdNUw+XKxwQJQ=;
        b=ux96KxFoBQb1pEELzL9q41c5c6FV6JirysQKVe9p/OLfvwX0TyG52+mMn0tAROXlPh
         OnMfg6kbw4RkigqT/zuag7KCvbX/8QcAdIzjXb+ke94XKljKktRRZixQcOYxKr3mJL+9
         hHvoMAavD1Q/zqXWVLf5IHfEaGvjIdg27jqX+VkcfKcf22dClafmalGkAY19KoLhCNBw
         vdFKkKnQHZi2vXTAx4zhJXdMnS4iQMNNoVJF5hd2C2DIFGA7bcAS4v67IaPfUoXLHK3W
         8d/hUjiPpYfBUjpe0ByHi7/HOA7CTwAIcENHbE9xjYsUL+BH7VV/WC+LFQete3LE84IZ
         WeJQ==
X-Gm-Message-State: AOAM53061PZ1kvT+RBJb00fvo0Y/xfjJXLj+rn5PLCNwiUye26P1F9Co
        +nleA0Hc2BdVPypzgpukq70=
X-Google-Smtp-Source: ABdhPJx/MXRBrYP+QGXwuZ0tnoElNQp9Zc9CerAJQCnSxfMAg3qhqJoCOjeyXPIvMkCS3q+BdiUOZA==
X-Received: by 2002:adf:f042:: with SMTP id t2mr21716281wro.180.1636741754722;
        Fri, 12 Nov 2021 10:29:14 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id d7sm6218541wrw.87.2021.11.12.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 10:29:14 -0800 (PST)
Date:   Fri, 12 Nov 2021 19:29:12 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, kbuild-all@lists.01.org,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [helgaas-pci:pci/driver 17/24] drivers/misc/cxl/guest.c:34:29:
 sparse: sparse: incorrect type in assignment (different modifiers)
Message-ID: <YY6yeIFReq+iahqJ@rocinante>
References: <202111121836.Oiqcphv0-lkp@intel.com>
 <YY5v0wzW192k1fG+@rocinante>
 <CAPcyv4g403nTri81CFYBdnw7E9mno94zE9ntEsafs6_QRuxGJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPcyv4g403nTri81CFYBdnw7E9mno94zE9ntEsafs6_QRuxGJA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dan,

> Note that drivers/misc/cxl/ != drivers/cxl/
> 
> The former is CAPI Accelerator Link (?), and the latter is Compute Express Link.

Ah!  Got it.  Apologies for causing some commotion here then.  I simply
called upon all the resident CXL experts I could think of.

	Krzysztof
