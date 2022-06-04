Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DC053D882
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jun 2022 22:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbiFDUad (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 16:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiFDUab (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 16:30:31 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54B222A1
        for <linux-pci@vger.kernel.org>; Sat,  4 Jun 2022 13:30:29 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w3so9226420plp.13
        for <linux-pci@vger.kernel.org>; Sat, 04 Jun 2022 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/HBb0ZDkKChS7u7W92q6z+RJ56Q8ZTddXO5nLVdm7Ds=;
        b=P9CwzByv7YgasmohkFwhBdbjzvwEj+asz8ddZId+WOAo1rW80xt71SlfNQjChfKryA
         wsOQcEWIagvMoLVuqx/Wl04bzWcJiucwtVHxpf+pl+ZTjtZY57pdASshNB27LMmG+Zjx
         uWQ1GkoBKbMEn58u3OWvQ2kPRb7gAZzYQXH8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/HBb0ZDkKChS7u7W92q6z+RJ56Q8ZTddXO5nLVdm7Ds=;
        b=oYK8+a64gMM48mmGtYRRmLvt45X1ScWT0c9w1PbHlOoSHKt36h+ov5+4s/wWciMFQ+
         /UnO7Sr2cuyc3zG+9/OwzDQADkvdhqg9UQz1T2gCxz9K444KbqXxIxvH7EiNzrVUlq6u
         2goR4km/eITKa9ysZYHZye3kSuR5MGXodSZPLK/Xa/W49Ui8gQIk0TUbIAz5q1l+t1+/
         cf5/5bUxJQgWchqWaqUmWfvNZphCRa/JM60w7MS8688xpLrdrisxe4qGkbnIN4IBF8j5
         AvYrbNMPlK5AFBjJNWtSRfKTBpsXHNXKUggYixwMZj81iQbapBRjCfv69yTcJFe6+eDr
         Nbaw==
X-Gm-Message-State: AOAM532v01HYUntLjUC47W6at3bKKVm7v8loYTsJvgDc1T/pLcw7aP37
        D8X2Ac+q1h6zagDqKOm/SCEgMw==
X-Google-Smtp-Source: ABdhPJwtXs6I68jQqRzep0xqec3GlALJ3iL77SWf2Owq4SCVbCGHKE8Dm7lcxheeLXbH6VLIAOVrIw==
X-Received: by 2002:a17:902:eccc:b0:167:5c6e:31e4 with SMTP id a12-20020a170902eccc00b001675c6e31e4mr5543306plh.90.1654374628607;
        Sat, 04 Jun 2022 13:30:28 -0700 (PDT)
Received: from irdv-mkhalfella.dev.purestorage.com ([208.88.158.128])
        by smtp.googlemail.com with ESMTPSA id l63-20020a638842000000b003f61c311e79sm6530196pgd.56.2022.06.04.13.30.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2022 13:30:27 -0700 (PDT)
From:   Mohamed Khalfella <mkhalfella@purestorage.com>
To:     helgaas@kernel.org
Cc:     bhelgaas@google.com, ebadger@purestorage.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, mkhalfella@purestorage.com,
        msaggi@purestorage.com, oohall@gmail.com, rajatja@google.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Iterate over error counters instead of error
Date:   Sat,  4 Jun 2022 20:30:21 +0000
Message-Id: <20220604203021.10663-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220603235856.GA117911@bhelgaas>
References: <20220603235856.GA117911@bhelgaas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/3/22 16:58, Bjorn Helgaas wrote:
> On Fri, Jun 03, 2022 at 10:12:47PM +0000, Mohamed Khalfella wrote:
>> Is there any chance for this to land in 5.19?
>
> Too late for v5.19, since the merge window will end in a couple days.
> Remind me again if you don't see it in -next by v5.20-rc5 or so.
>

Thank you. I will keep an eye on -next.

>> On 5/10/22 14:17, Mohamed Khalfella wrote:
>>>> Thanks for catching this; it definitely looks like a real issue!  I
>>>> guess you're probably seeing junk in the sysfs files?
>>>
>>> That is correct. The initial report was seeing junk when reading sysfs
>>> files. As descibed, this is happening because we reading data past the
>>> end of the stats counters array.
>>>
>>>
>>>> I think maybe we should populate the currently NULL entries in the
>>>> string[] arrays and simplify the code here, e.g.,
>>>>
>>>> static const char *aer_correctable_error_string[] = {
>>>>        "RxErr",                        /* Bit Position 0       */
>>>>        "dev_cor_errs_bit[1]",
>>>> 	...
>>>>
>>>>  if (stats[i])
>>>>    len += sysfs_emit_at(buf, len, "%s %llu\n", strings_array[i], stats[i]);
>>>
>>> Doing it this way will change the output format. In this case we will show
>>> stats only if their value is greater than zero. The current code shows all the
>>> stats those have names (regardless of their value) plus those have non-zero
>>> values.
>>>
>>>>> @@ -1342,6 +1342,11 @@ static int aer_probe(struct pcie_device *dev)
>>>>>  	struct device *device = &dev->device;
>>>>>  	struct pci_dev *port = dev->port;
>>>>>
>>>>> +	BUILD_BUG_ON(ARRAY_SIZE(aer_correctable_error_string) <
>>>>> +		     AER_MAX_TYPEOF_COR_ERRS);
>>>>> +	BUILD_BUG_ON(ARRAY_SIZE(aer_uncorrectable_error_string) <
>>>>> +		     AER_MAX_TYPEOF_UNCOR_ERRS);
>>>>
>>>> And make these check for "!=" instead of "<".
>>
>> I am happy to remove these BUILD_BUG_ON() if you think it is a good
>> idea to do so.
>
> I think it's good to enforce correctness there somehow, so let's leave
> them there unless somebody has a better idea.
>
>>> This will require unnecessarily extending stats arrays to have 32 entries
>>> in order to match names arrays. If you don't feel strogly about changing
>>> "<" to "!=", I prefer to keep the code as it is. 
