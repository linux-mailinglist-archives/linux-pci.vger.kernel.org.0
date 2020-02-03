Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3147150267
	for <lists+linux-pci@lfdr.de>; Mon,  3 Feb 2020 09:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgBCISH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Feb 2020 03:18:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55982 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbgBCISH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Feb 2020 03:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580717885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrlD/wgdUBtVzwn2ikuTQOIVSG3OPC/dcn0ZKFc6/Gs=;
        b=Fza/D2YAtP+yh4T8xquu9UMFcsBn7oeHirAg6/CNH2zBpfJKO7zwGtpCIouq7xr51Y4SRB
        JoNfwVBoQR5e+V2MKvWwVP/by9+mN44vb6J9UYp2eFPtSVqzq0crZlG7ZG/x01qvWSWOQ+
        JIFsFjL769hq1iQkItoUr6SGBpnEFFA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-bipk_wBYODClsX-UW0ivfw-1; Mon, 03 Feb 2020 03:18:04 -0500
X-MC-Unique: bipk_wBYODClsX-UW0ivfw-1
Received: by mail-wm1-f71.google.com with SMTP id d4so3707688wmd.7
        for <linux-pci@vger.kernel.org>; Mon, 03 Feb 2020 00:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrlD/wgdUBtVzwn2ikuTQOIVSG3OPC/dcn0ZKFc6/Gs=;
        b=bsMOod6jGv7h6re0x6urRnHZd3cz9ctUoAL6MGgZjvw9YqR3TUcqbu7s2JEP2g77gi
         iqNrJv7mbteBlyYt6NaqeSwkoliWrQdEmfVXOZGsjh73kes4BhVxtS57CZ/+PRmmVpXj
         Q2Kh5USYbMrOrsn1GNVY3Pl2S760aJoHtwXhf783KICFXfc5sNX//h5oJsAFgM7ef7x5
         gUJqfrsmHCoqChWXBqHVx0podz8OBVDa1c/76Q1RmKxwJAiib+CU9O4R0phZEsBsVkr3
         iYJW6qeMfsCGvsOhmsWV2v/hkk2N9RyhDWBuTeMC8A/BtzGFOVnejdJOVmbf2dUttLOd
         SCeQ==
X-Gm-Message-State: APjAAAVJZEm4KDbSYYTuY8IchbKRo3KBJ1sBmFsjUx/SymZOREjlQhOq
        TjAz3OcZFFFK51icerX+JhGfb67WlK1zioTROHBf6S9cEvoWG4hzXTVSX5YfX5N0Gzx/y8G/knt
        cMX7d+NMtYxAEGitBNfiT
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr3034924wro.359.1580717881768;
        Mon, 03 Feb 2020 00:18:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqx9FVGQu5t2tcyaJhvPoLSS22q7NWyktDP3a+A/plvQOaRTXOMjAlgdnv0obzO54kAOXWlZ3A==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr3034870wro.359.1580717881333;
        Mon, 03 Feb 2020 00:18:01 -0800 (PST)
Received: from localhost.localdomain ([151.29.2.83])
        by smtp.gmail.com with ESMTPSA id r3sm24850786wrn.34.2020.02.03.00.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 00:18:00 -0800 (PST)
Date:   Mon, 3 Feb 2020 09:17:58 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudio Scordino <c.scordino@evidence.eu.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [ANNOUNCE][CFP] Power Management and Scheduling in the Linux
 Kernel IV edition (OSPM-summit 2020)
Message-ID: <20200203081758.GI8582@localhost.localdomain>
References: <20191219103500.GC13724@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219103500.GC13724@localhost.localdomain>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 19/12/19 11:35, Juri Lelli wrote:
> Power Management and Scheduling in the Linux Kernel (OSPM-summit) IV edition
> 
> May 11-13, 2020
> Scuola Superiore Sant'Anna
> Pisa, Italy
> 
> ---

[...]

> .:: SUBMIT A TOPIC/PRESENTATION
> 
> To submit a topic/presentation add its details to this list:
> https://docs.google.com/spreadsheets/d/1pPU2ybHHoQjqicYLTaNanPz9H5fv6mQTtrzOqwP9uHs/edit?usp=sharing
> 
> Or, if you prefer, simply reply (only to me, please :) to this email
> specifying:
> 
> - name/surname
> - affiliation
> - short bio
> - email address
> - title
> - abstract
> - 30min or 50min slot
> 
> Deadline for submitting topics/presentations is 10th of February 2020.
> Notifications for accepted topics/presentations will be sent out on 24th
> of February 2020.

A quick one to remind that deadline for submitting topics is
approaching.  Please take time to think about what you'd like to discuss
at the summit and to add the topic to the list.

Best,

Juri

