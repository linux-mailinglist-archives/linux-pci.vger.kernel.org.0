Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B938B233EFD
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 08:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731403AbgGaGTY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jul 2020 02:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731341AbgGaGTY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 Jul 2020 02:19:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7E0C061575
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 23:19:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 3so8186738wmi.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qPKXXpJdjKCrkxbnD31J9NcdUb/tXEBn+ARL8Y6Ysd8=;
        b=tXVqKIx9YeutJTEwLUXbENDyhttvDO3dblr6fxNoUIoyOSofGamNKD+xTV0WpAfiEG
         3ETCLAtRqNYrUxOT8PIb1nlELDzskGVDilJdLjyn69+hgV+lW/viQf+ympqGXsDJo9xD
         sY/kqBtch/f0zMWm1AVKLTE9ZGdpSTtfzRjrkNU5oWnX/gbBMQNZJis6dQY9ZVuDr/Ph
         tUPi0o6j4p5N89JlWf62pCKWk/t36X1Mdf/pz9wMf3LNac7hKSDW604IMOJJTNEiwg9l
         xwiVZQ9EAUdWLT2hXFEUlY5jGh1Fz6m8IQORxoTZDMtO33eEQkiouNcCDRBj7zo8AGmt
         K00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qPKXXpJdjKCrkxbnD31J9NcdUb/tXEBn+ARL8Y6Ysd8=;
        b=qvuHv2iPdPj5Fc6P+nSfD33wpw7SDm6mzJWZmWgE3PGUdW/KqVEiCsDwtzqh3uD/bo
         vKrLdtMSml1OBmlY//B3D2rjK9+M8/613IXvsfZ4Nr7/A81psjuMQsgYjhuv2EyumDXg
         7OcHcuY2b/2UanR/2H/BC24h//onfy2MCp0MO+2lje03SEOpaUXFVzqqlQ3Lr4i1VHcd
         Mj9ooOkUS4ezWk6xpbrhU372ByIoUKlMlNrkL0kmIhKz15esLI2zxxmice9eCQeT6XdL
         xjXHljs/M4QhXaxwFX5gia5CuOkhKOe+5fCAVSw7QVnmUslLOnNjSddiLYR4t5m75aGY
         jMuw==
X-Gm-Message-State: AOAM531OT2RZxc2OOLyl1YH94/OdZGzHp6bNLeCrVL0VSvZGz/5X3fe9
        VuNXcNB0/Q9xMwNJxJ+Dl+qSeg==
X-Google-Smtp-Source: ABdhPJwcZeUYAOIT7hP4EH+JmFxHst2IgQ5lloYBKPkq4SUaU7RgmepyQcQ91JfPqooLOOrlqaMcEA==
X-Received: by 2002:a1c:dc02:: with SMTP id t2mr2360258wmg.55.1596176362350;
        Thu, 30 Jul 2020 23:19:22 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id n24sm4604652wmi.36.2020.07.30.23.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 23:19:21 -0700 (PDT)
Date:   Fri, 31 Jul 2020 07:19:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark D Rustad <mrustad@gmail.com>
Cc:     "David E. Box" <david.e.box@linux.intel.com>, dvhart@infradead.org,
        andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V4 2/3] mfd: Intel Platform Monitoring Technology support
Message-ID: <20200731061919.GJ2419169@dell>
References: <20200714062323.19990-1-david.e.box@linux.intel.com>
 <20200717190620.29821-3-david.e.box@linux.intel.com>
 <20200728075859.GH1850026@dell>
 <3DCA0A88-0890-49EE-8644-E6311E891C55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3DCA0A88-0890-49EE-8644-E6311E891C55@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 29 Jul 2020, Mark D Rustad wrote:

> at 12:58 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > If you do:
> > 
> > 	do {
> > 		int pos;
> > 
> > 		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> > 		if (!pos)
> > 			break;
> > 
> > Then you can invoke pci_find_next_ext_capability() once, no?
> 
> Part of your suggestion here won't work, because pos needs to be initialized
> to 0 the first time. As such it needs to be declared and initialized outside
> the loop. Other than that it may be ok.

Right.  It was just an example I quickly hacked out.

Feel free to move the variable, or make it static, etc.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
