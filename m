Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8089D4F6CEE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Apr 2022 23:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbiDFVjx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Apr 2022 17:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiDFViO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Apr 2022 17:38:14 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002D4198535
        for <linux-pci@vger.kernel.org>; Wed,  6 Apr 2022 13:56:05 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 12so3659936oix.12
        for <linux-pci@vger.kernel.org>; Wed, 06 Apr 2022 13:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fB8abMIxXhMlTFQ9Us/AuUms2KKMwE9BtNrsYKnRWxU=;
        b=dAaf334GMP778E6d8TxUv0rA3XQL5tbQ4YACJ9Assr63Va6mcLNkL4Ol0aUzkHlOqE
         1JcRbCW2ffjEmQnfzIS4IGp7LJZzAeYOs7HihPhxfJV/OhZi4EkffRGlYFuRtGpqvrOJ
         GzpbHXw4pWedGYL+yfa4X8UxfgotPiqK84hjbmwq/bkPmIa4/3cilHCVV/G4PjCRISTR
         BA9uvZDwrzSvltZEMXseNGcNWB5HCuE7wk11UDVyTcvY65nik+lcVwc5RlnkD+hlQTTW
         THBImZjAhYsShUV+0lCpLnS/s9w/uCi9yKZn14+6ZALmlORnT8HlzEOqev+O9lWbRIKk
         O9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fB8abMIxXhMlTFQ9Us/AuUms2KKMwE9BtNrsYKnRWxU=;
        b=pH7iN0ZzPQobUwinimJOzuPePuc7b1YH8xBU2inKy7q7lNsKv1c8WJpZIQk5o/Y95C
         2k42EiIr0mx0qsBRUQXkZnGn+f8k+Y+DAcrv4vUwVtlxBvUxITk0rBjdznpqG047qK6N
         zBGgjfuCLve/dAaoAraFdhpJisPhN4Uh81XQAA6RX5AM9dh/2RHTNPvOYXX3/5KeW9z2
         kGv4Ht8cRTm2/rMl7mVI20b3yW96TiIa/DrciDNxIvT09twTKbu0Jb8f8crezTUGj/7r
         8vcODH3RIIWhF31mGv0DFgYBrp5L+3JU/k8Ty8SkaHddopOluEWUBYi4krZ4kkOf777/
         bwzg==
X-Gm-Message-State: AOAM530WIJwv53xAFOzQZcu1M1tRAc7XTnSODym0Uu4nQciR5+WIvOzi
        jFRmjP7O9m7ULc89wFhicLo=
X-Google-Smtp-Source: ABdhPJxUS84vJRfRprP2yuIUhlO8twF71UcymdVx39UWwV4d7uUdS0LaI3Fio3GIKOoJYUN1vJ6+tw==
X-Received: by 2002:a54:4608:0:b0:2d9:91fa:74f with SMTP id p8-20020a544608000000b002d991fa074fmr4212100oip.65.1649278565342;
        Wed, 06 Apr 2022 13:56:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a056870920400b000e1bdf90ba5sm6429117oaf.22.2022.04.06.13.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:56:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Apr 2022 13:56:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        kernelci-results@groups.io, bot@kernelci.org,
        gtucker@collabora.com, linux-pci@vger.kernel.org
Subject: Re: next/master bisection: baseline.login on asus-C523NA-A20057-coral
Message-ID: <20220406205602.GA3711131@roeck-us.net>
References: <20220405235315.GA101393@bhelgaas>
 <20220406185931.GA165754@bhelgaas>
 <Yk3r9uhIHmNumtxi@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk3r9uhIHmNumtxi@sirena.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 06, 2022 at 08:37:26PM +0100, Mark Brown wrote:
> On Wed, Apr 06, 2022 at 01:59:31PM -0500, Bjorn Helgaas wrote:
> > On Tue, Apr 05, 2022 at 06:53:17PM -0500, Bjorn Helgaas wrote:
> 
> > > Is there any way to get the contents of:
> 
> > >   /sys/firmware/acpi/tables/DSDT
> > >   /sys/firmware/acpi/tables/SSDT*
> 
> > > from these Chromebooks?
> 
> > Is there hope for this, or should I look for another way to get this
> > information?
> 
> I believe Guillaume is out of office this week.  Copying in Guenter as
> well since he's on the ChromeOS team in case he can help or knows
> someone who can.

I _think_ the source should be in
https://chromium.googlesource.com/chromiumos/third_party/coreboot,
branch firmware-coral-10068.B,
in src/mainboard/google/reef/variants/coral/devicetree.cb.

Does this help, or do you need the actual binary devicetree file(s) ?

Guenter
