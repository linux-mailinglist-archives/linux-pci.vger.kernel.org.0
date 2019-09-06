Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA0DABD5A
	for <lists+linux-pci@lfdr.de>; Fri,  6 Sep 2019 18:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405894AbfIFQLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Sep 2019 12:11:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44298 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbfIFQLn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Sep 2019 12:11:43 -0400
Received: by mail-pf1-f195.google.com with SMTP id q21so4792693pfn.11;
        Fri, 06 Sep 2019 09:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j/RCygqup/ozIXYfBYxr7Rfuk4dQDnBnOfDAkhoVTcE=;
        b=rp7S2IVH7njXUDp7Ao83f6kUscxQRK07wr16NlaTLo9oiCNxXr4lVr754Mh2ze7FTt
         0IOOsVQGU0uZUaDK0TA8Z5wEmjNnz2Yda2hDeSf9GN/iFVv14ViYfPRyYqb98PS+oK4/
         X/YIbs/ga7LZjbSefTKTaLRDj/kKFfB5GOxmuU/19clLjRM6sb09JjsG9lNs0Wi5p3VM
         tC4h2UfEDOm4eThns6Wlohs3SkozlgMx5hOEmrfHahdM7uK/CF00qiiKlc4Q7rd2WoCP
         0uNGMfGTWDlDmZtMCKEf8F7UjoQWtEdL+s7biIUgBWXmMpsRXU7PAAIxATZbLMoIuub0
         Rfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=j/RCygqup/ozIXYfBYxr7Rfuk4dQDnBnOfDAkhoVTcE=;
        b=SkQGxv2nF/EWa49JS3NhbbG4aGCulbJRqYgSqQXs7XDkxVC4csCRDCG7iThAglriZS
         oL8BSVRq1ufFV02JqFKTye8eKVBHgT5zu6/RqaPL1+dVQCLltf4tjfWNO5DJmf3mJb6E
         feJTZ3swmr31aL3tl5sfqsQARBTtNn/gqI4SPh9wuWv7e2RP+SwGuUE0GMRgPvIUMhcV
         UgJ1SjHAEru/yQD4QcPis0h90DAUQK2T3GSoMUDTMSndy2StRIIieoRLOuOKAKd7yTEr
         86vte4U0ntyt6v4zJX+J6QUu83EBtsFFQZT4moVQyPfP2vg+gS4Rja4e8i+zoHKDk0oe
         E9EA==
X-Gm-Message-State: APjAAAXW9iKxYes3vI1Ca0OLm31cAvDRZ6EDEEzGyoHGL2vqpbEMb4r/
        Q1ub1tzGsq0CC0Vki14xdJ8=
X-Google-Smtp-Source: APXvYqyXkIS7dluYvRnhhC+Dskl36pOgKXaJFUroujwwdBV6MGQmt60JHT0LlgooALNH4fl6LPJ1Pw==
X-Received: by 2002:a65:64c6:: with SMTP id t6mr8766079pgv.323.1567786302342;
        Fri, 06 Sep 2019 09:11:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h18sm6729854pfn.53.2019.09.06.09.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Sep 2019 09:11:41 -0700 (PDT)
Date:   Fri, 6 Sep 2019 09:11:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Boris Petkov <bp@alien8.de>
Cc:     Isaac Vaughn <isaac.vaughn@Knights.ucf.edu>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        x86@kernel.org, linux-hwmon@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] Add PCI device IDs for family 17h, model 70h
Message-ID: <20190906161140.GB25316@roeck-us.net>
References: <BN7PR07MB5186DD5732B95B784A9D46BFCEB80@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190904215308.GA12374@zn.tnic>
 <BN7PR07MB5186E542BB3AD734262AA345CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905070917.GA19246@zn.tnic>
 <BN7PR07MB51864F8287CAD4847BF17A83CEBB0@BN7PR07MB5186.namprd07.prod.outlook.com>
 <20190905135408.GE19246@zn.tnic>
 <20190905215650.f8b5d22b625ddcff7d093883@knights.ucf.edu>
 <20190906091250.GB19008@zn.tnic>
 <20190906130206.GB7255@roeck-us.net>
 <6B3FCC26-7A2F-438F-B442-EA665DDD0569@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B3FCC26-7A2F-438F-B442-EA665DDD0569@alien8.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 06, 2019 at 03:09:16PM +0200, Boris Petkov wrote:
> On September 6, 2019 3:02:06 PM GMT+02:00, Guenter Roeck <linux@roeck-us.net> wrote:
> >Also, how is this patch different to the patches already in linux-next
> >?
> 
> Which are those? Care to share their linux-next commit IDs with us? 
> 

12163cfbfc0f ("hwmon: (k10temp) Add support for AMD family 17h, model 70h CPUs")
af4e1c5eca95 ("x86/amd_nb: Add PCI device IDs for family 17h, model 70h")

Guenter
