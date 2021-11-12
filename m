Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC56644DF41
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 01:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhKLArV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Nov 2021 19:47:21 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:40747 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhKLArV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Nov 2021 19:47:21 -0500
Received: by mail-ed1-f50.google.com with SMTP id b15so30681162edd.7;
        Thu, 11 Nov 2021 16:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rIolFV18ROhRnMldpjywPitw8ktHtm2VqFmu1UrAgzU=;
        b=BwQ4rH/k7nlHnxSIXGzwx1oeZrTVBMcdAVaYO1BnDY1d/wg2eIJxxCAzApA1zcYwBM
         bSWk2B28l8QKfTVDwiroWhrnGveZkN0bRX5Q0YTS129gc+qaL6F332jCMPRc7GJpRjnA
         uVXJofajFmqyiCblLlF3RLkpjSYYF46Om/T6uTvKF9y6Td/Bf0rOGl7KcLSVCYqzhrzf
         gqBAAC6SGCStQ+mlz99eHMtC8po8pNgJo+Oo6rqwlM9beRi0/JySucLy4JU6MMaEBPRF
         g/FDdkgTwDh/jBRLLr32eM8EOGWpcm+cMIRves/XpLVRsPkGRVaMg0jtivvJ2cZa9CmY
         5nfg==
X-Gm-Message-State: AOAM530VXMeCobJLEK6IEK4tj8b239CW7gyBjPa8lmanhHQlqNc8fi92
        1eyyGG0xmmhE+NJFM6dZcn8=
X-Google-Smtp-Source: ABdhPJyYYgPYGyZ+BJy7VxuyE0v1uPjrshJHZDASLWR2/zdwq7aw1z1bUGKeE88LyDp34SH/Tlsc9Q==
X-Received: by 2002:a17:907:168f:: with SMTP id hc15mr14485618ejc.115.1636677870417;
        Thu, 11 Nov 2021 16:44:30 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id bm2sm2334559edb.39.2021.11.11.16.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 16:44:29 -0800 (PST)
Date:   Fri, 12 Nov 2021 01:44:29 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     "Bao, Joseph" <joseph.bao@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, Sasha Levin <sashal@kernel.org>
Subject: Re: HW power fault defect cause system hang on kernel 5.4.y
Message-ID: <YY247SPgRT8OpNrF@rocinante>
References: <DM8PR11MB570219FE94A7983E0F61A3BA86929@DM8PR11MB5702.namprd11.prod.outlook.com>
 <20211109152951.GA1146992@bhelgaas>
 <DM8PR11MB57020F3491E508A334469E2186949@DM8PR11MB5702.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR11MB57020F3491E508A334469E2186949@DM8PR11MB5702.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Adding Sasha for visibility]

> Thanks for the encouragement! Stuart already helps patch the hang issue,
> do I still go an open a report at https://bugzilla.kernel.org? 

I am not sure what Bjorn would say here, however personally I say that it
would be nice if you do open a bug there, if you have a minute, as it might
help someone else who would stumble into this issue - a lot of people
searches through Kernel's Bugzilla as part of their troubleshooting.

Also, as this is a hang in 5.4, and a lot of people uses this kernel, it
might warrant a back-port to stable and long-term kernels.

	Krzysztof
