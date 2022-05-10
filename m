Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701D522638
	for <lists+linux-pci@lfdr.de>; Tue, 10 May 2022 23:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbiEJVSL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 May 2022 17:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbiEJVSK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 May 2022 17:18:10 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C222550E3C
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 14:18:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d25so219436pfo.10
        for <linux-pci@vger.kernel.org>; Tue, 10 May 2022 14:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=awoehg3DVkTpMr0e5SN/82sAnQC4XZwnwHUruoursgM=;
        b=YOVGXr/JNn7NPSjYf6oP+U8flXTU/H4OMQVFHnoQVQuCp2dBXGFb9os69kFhKPM+jU
         XxEUW2pDQQ+IGcYmCKHU98xeAA4ITlEn3HdAuXDn3DLswU8FXoXJ65NYjunr3bbwVYNI
         uGqjwirWmx1i3EU+2R9eK6WKw7QiCvfCoeX6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=awoehg3DVkTpMr0e5SN/82sAnQC4XZwnwHUruoursgM=;
        b=tWiuzVHjxqjSw9wL8ZKe84eqzRWHqoYuvfGxfmfCpx73brDEYShLdzM8GczKzdF9ay
         GU8Ha8ANMU37ZiwplC7O6AHkWXhYwENR/AZFlYkPcoE3/UR75Bam3GChMzFa5sqXC7Pe
         oCa9EcOZ3Y41EN7j80zU4GEe6M+8DXPMI6nB4v7szIOnDHyJuHPhv5hwYmBtff8P1nwz
         /Hq1pcgs5SmS9ET6NgIhN6cFmbzjx8VAfh5eFHNKeYg71SOfJ6kpObkGGbdLMhNHV/Sq
         LHR+yMNrA+lwb2B9jDba8jTdtCm7Sw7u2SUwroW+Ufx49wDfkRd8zm4Gn+oI6znslJ0K
         ShlQ==
X-Gm-Message-State: AOAM532sKXhCGUIDE1Y04Ji19CsspRcvi52d00dVXsIAdjAjOycIVPNF
        2DtSzs5GONMzm1u4mHM2msvyQw==
X-Google-Smtp-Source: ABdhPJx2RIAdUHBPstsH1ktBxYBfA3XcFRMgePn6fEJlQiEEWiujS3M+X1iD3LDGO6ShbUNTSTT8ew==
X-Received: by 2002:a05:6a02:11a:b0:3c3:dabd:eafb with SMTP id bg26-20020a056a02011a00b003c3dabdeafbmr18680769pgb.87.1652217488225;
        Tue, 10 May 2022 14:18:08 -0700 (PDT)
Received: from irdv-mkhalfella.dev.purestorage.com ([208.88.158.128])
        by smtp.googlemail.com with ESMTPSA id s55-20020a056a001c7700b0050dc76281a2sm6618pfw.124.2022.05.10.14.18.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2022 14:18:07 -0700 (PDT)
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, ebadger@purestorage.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mkhalfella@purestorage.com,
        msaggi@purestorage.com, oohall@gmail.com, rajatja@google.com,
        ruscur@russell.cc, stable@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Iterate over error counters instead of error
Date:   Tue, 10 May 2022 21:17:56 +0000
Message-Id: <20220510211756.5237-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220510164305.GA678149@bhelgaas>
References: <20220510164305.GA678149@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Thanks for catching this; it definitely looks like a real issue!  I
> guess you're probably seeing junk in the sysfs files?

That is correct. The initial report was seeing junk when reading sysfs
files. As descibed, this is happening because we reading data past the
end of the stats counters array.


> I think maybe we should populate the currently NULL entries in the
> string[] arrays and simplify the code here, e.g.,
> 
> static const char *aer_correctable_error_string[] = {
>        "RxErr",                        /* Bit Position 0       */
>        "dev_cor_errs_bit[1]",
>	...
>
>  if (stats[i])
>    len += sysfs_emit_at(buf, len, "%s %llu\n", strings_array[i], stats[i]);

Doing it this way will change the output format. In this case we will show
stats only if their value is greater than zero. The current code shows all the
stats those have names (regardless of their value) plus those have non-zero
values.

>> @@ -1342,6 +1342,11 @@ static int aer_probe(struct pcie_device *dev)
>>  	struct device *device = &dev->device;
>>  	struct pci_dev *port = dev->port;
>>
>> +	BUILD_BUG_ON(ARRAY_SIZE(aer_correctable_error_string) <
>> +		     AER_MAX_TYPEOF_COR_ERRS);
>> +	BUILD_BUG_ON(ARRAY_SIZE(aer_uncorrectable_error_string) <
>> +		     AER_MAX_TYPEOF_UNCOR_ERRS);
>
> And make these check for "!=" instead of "<".

This will require unnecessarily extending stats arrays to have 32 entries
in order to match names arrays. If you don't feel strogly about changing
"<" to "!=", I prefer to keep the code as it is. 
