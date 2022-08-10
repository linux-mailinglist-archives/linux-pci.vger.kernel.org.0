Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038E958EDDE
	for <lists+linux-pci@lfdr.de>; Wed, 10 Aug 2022 16:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiHJOGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Aug 2022 10:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiHJOGT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Aug 2022 10:06:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074D5A153
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 07:06:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t22so14867050pjy.1
        for <linux-pci@vger.kernel.org>; Wed, 10 Aug 2022 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=UBYU1kWWO5JShEdSdGq0yMGTNDTq36UYslphzmafG8s=;
        b=Wlg08SgTx0wDhTB7jgmjbuq/9ta+oM7GzobRnjxXnWsNDdfnCkQ7Qbewz5gys9rdUP
         Qa8hHLPPLCOuhJuTQXdT2rGQe5C7xPZp1byfTP4N8fjUQDzNs1I5NtKU3Wbdpy7KKWiW
         pksa4e8MrejYoUimk/rMzGNfXALmxiBXBSXJw9T/wVcubszVPUTq+J8eAwrCUIaxNY8O
         xAaeWRQpwt+OtFTpFlnBN0I4y0tC0od5UNni5t2snLVhOC8W5n1sM0N9WeZk/4R/Mzwe
         bgYhh/JEOZi/B98Lrx/ur1sU050CKTfpw5F9HgOztPa8m4zN2wgrCrtSkk7vfLR7biJD
         D3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UBYU1kWWO5JShEdSdGq0yMGTNDTq36UYslphzmafG8s=;
        b=GEEf/lbE8yYBvLrrejsplTqyRQ9aAR5RkzOPcA8q+TshLCjUxnwXEYzxS+NrN9Lh8R
         eJViykCA8sMfk1EgSwyAWHb8mWd/veul/ttO7dn/MuMlmd7DOHcJJxTxUFJwBT/7MusZ
         el9z2RuPtI133rUkMzdpoW0K2kwXjyc6v9yHHBAIG5b14FR53EZ1GrI7nXzVCrD8rBcb
         9aBayu/aRwEXIf+NUFFVtoTkJegdOUdUYaAMtIE8OYMVmCGzA83ekbqkhV0n+JxHmuIJ
         fgxm34667CFEDV2qmv4163s1fZAHERS8SaMwvFZUHUdO/h/SKgB+Y5EoKXHNif8SW/zz
         KfWA==
X-Gm-Message-State: ACgBeo1P39wTYrUAe/5QHErY1aod4+SHeA8sONhnLVJC725z3OQZh9pV
        tFkZi6ooi5uRVZ0j9ktsvweGBQ==
X-Google-Smtp-Source: AA6agR70y8QZ2gsWb688PhZB222/NbLZNKzQpqlPNAEs8p8Y6kKCKyMBGdjttv8Cal6Esj9JRC+xHw==
X-Received: by 2002:a17:90a:fd06:b0:1f3:29d8:72d8 with SMTP id cv6-20020a17090afd0600b001f329d872d8mr3854290pjb.23.1660140374693;
        Wed, 10 Aug 2022 07:06:14 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090a68cc00b001f50c1f896esm1633944pjj.5.2022.08.10.07.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 07:06:14 -0700 (PDT)
Date:   Wed, 10 Aug 2022 07:06:12 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com,
        gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION] changes to driver_override parsing broke DPDK
 script
Message-ID: <20220810070612.5860d673@hermes.local>
In-Reply-To: <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
References: <20220809192102.GA1331186@bhelgaas>
        <af880c1a-cedd-181f-9b4d-2f1766312fc0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 10 Aug 2022 08:54:36 +0300
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> >> The script is sending single nul character to remove override
> >> and that no longer works.  
> 
> The sysfs API clearly states:
> "and
>  may be cleared with an empty string (echo > driver_override)."
> Documentation/ABI/testing/sysfs-bus-pci
> 
> Sending other data and expecting the same result is not conforming to
> API. Therefore we have usual example of some undocumented behavior which
> user-space started relying on and instead using API, user-space expect
> that undocumented behavior to be back.
> 
> Yay! I wonder what is the point to even describe the ABI if user-space
> can simply ignore it?
> 
> Best regards,
> Krzysztof

The code that does this in the python script is relatively old.
The writing of null was introduced back in 2017 by:

commit 720b7a058260dfd6ae0fcce956bfe44c18681499
Author: Guduri Prathyusha <gprathyusha@caviumnetworks.com>
Date:   Wed Apr 26 19:22:19 2017 +0530

    usertools: fix device binding with kernel tools
    
    The following sequence of operation gives error in binding devices
    1) Bind a device using dpdk-devbind.py
    2) Unbind the device using kernel tools(/sys/bus/pci/device/driver/unbind)
    3) Bind the device using kernel tools(/sys/bus/pci/driver/new_id and
    /sys/bus/pci/driver/bind)
    
    The bind failure was due to cached driver name in 'driver_override'.
    Fix it by writing 'null' to driver_override just after binding a
    device so that any method of binding/unbinding can be used.
    
    Fixes: 2fc350293570 ("usertools: use optimized driver override scheme to bind")
    
    Reported-by: Lijuan A Tu <lijuanx.a.tu@intel.com>
    Signed-off-by: Guduri Prathyusha <gprathyusha@caviumnetworks.com>
