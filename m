Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED25B21BFD6
	for <lists+linux-pci@lfdr.de>; Sat, 11 Jul 2020 00:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgGJWc3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 18:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgGJWc3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jul 2020 18:32:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCBCC08C5DC
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2020 15:32:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j18so7620074wmi.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2020 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=R3cCcxq/7DvlgBIfxzEZbh6H9mtns++bzLZKGAVA6YQ=;
        b=jMGNI+SV8weDHo8n7D8fmEf01/dCJmKOx46Y4kEtrjCiY+TohaYSGfY78ddC2QfIxn
         u9zX62mZfz7+bWrdZj16ZeYl+vQymmHUC7YeP5WL+EA6E+n+M85W/uS22mcepgIYYwYB
         DpJajpQ1YZ0Z9L0mNpNxIGaf21lGg3HwgM/Qm8fb5dqau+373n6USEl4iD74L6DXffQz
         YOurLsDIlnPmFi6X8nfk1DB2wMl+u83QzhWLNjQRMVcjtbVxW+BN6hVkszbjQmJ78ZON
         hbZzJnC3Lg4fAOmBl4a220cVMwF1xsUQo0wITN0qzRwOzr6phxClu7FntAPgtMrSPW/e
         9omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=R3cCcxq/7DvlgBIfxzEZbh6H9mtns++bzLZKGAVA6YQ=;
        b=ZwcKk2u3LB0raBGyQFWgGbduVP6AUsaTNEpB65GOej1ejvr6TomZM82pkOsQlRS8Hn
         KkAbjI9Oh753Qqsr0kC2fA+AC1rqT6eRIF0Ph6Va6W7ZYOuE8JiWeEpaVJnLrOwVuHwI
         GsEOqc8a2PNCC4lF1wrL2kR1JxHtpkq2Flg8Sifm/JE2pWA9Lqovab5rjSplx74TeB5B
         AmnUBo2KhpQXvsz/2iwfPAB8ThQ5yAl5ruwdAG1e1Jwn3ewEJg6sQwr8DQtVFo4Vw8mZ
         Nn78LaJyBKDNryWtDVN0fg8OY8RRGxvJr2FQrmrMjZTKxRtutM9jI/VFFO1Xwk0b7QDj
         88uQ==
X-Gm-Message-State: AOAM533V8YSX8TJ32C87Yi8FVQdXsWLDtkywZuXfS4/+84SqlWTj8u1y
        CkhnMWiLz9XHs6dBnXkY2V3RQ0pyJYcWUA==
X-Google-Smtp-Source: ABdhPJyTJZqhx7K6hmF8XNxXeypULS7lmdi2YPvp2ghFLs68PvF2ARGJ1ljtp7nbkidJ2mYeMQvIjg==
X-Received: by 2002:a1c:9911:: with SMTP id b17mr6875678wme.135.1594420347433;
        Fri, 10 Jul 2020 15:32:27 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id u16sm10814561wmn.11.2020.07.10.15.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:32:26 -0700 (PDT)
Subject: Re: [PATCH 0/11 RFC] PCI: Remove "*val = 0" from
 pcie_capability_read_*()
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org
References: <20200710001102.GA29833@bjorn-Precision-5520>
From:   Saheed Bolarinwa <refactormyself@gmail.com>
Message-ID: <a12a5519-2878-91e1-ea91-90970c1b4434@gmail.com>
Date:   Fri, 10 Jul 2020 23:32:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200710001102.GA29833@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 7/10/20 2:11 AM, Bjorn Helgaas wrote:
> The cc list is really screwed up.  Here's what I got:
>
>    Cc: Bolarinwa Olayemi Saheed <refactormyself@gmail.com>,
> 	  bjorn@helgaas.com,
> 	  skhan@linuxfoundation.org,
> 	  linux-pci@vger.kernel.org,
> 	  linux-kernel-mentees@lists.linuxfoundation.org,
> 	  linux-kernel@vger.kernel.org,
> 	  Russell Currey <ruscur@russell.cc>,
> 	  Sam Bobroff <sbobroff@linux.ibm.com>,
> 	  "Oliver O'Halloran" <oohall@gmail.com>,
> 	  linuxppc-dev@lists.ozlabs.org,
> 	  "Rafael J. Wysocki" <rjw@rjwysocki.net>,
> 	  Len Brown Lukas Wunner <lenb@kernel.orglukas@wunner.de>,
> 	  linux-acpi@vger.kernel.org,
> 	  Mike Marciniszyn <mike.marciniszyn@intel.com>,
> 	  Dennis Dalessandro <dennis.dalessandro@intel.com>,
> 	  Doug Ledford <dledford@redhat.com>,
> 	  Jason Gunthorpe <jgg@ziepe.ca>,
> 	  linux-rdma@vger.kernel.org,
> 	  Arnd Bergmann <arnd@arndb.de>,
> 	  "Greg Kroah-Hartman linux-rdma @ vger . kernel . org" <gregkh@linuxfoundation.org>
>
> The addresses for Len Brown and Lukas Wunner are corrupted, as is Greg
> KH's.  And my reply-all didn't work -- it *should* have copied this to
> everybody in the list, but Mutt apparently couldn't interpret the cc
> list at all, so it left the cc list of my reply empty.
>
> I added linux-pci by hand just so this will show up on the list.

Thank you. I have fixed this and some other issues, I just sent version 3.

- Saheed

