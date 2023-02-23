Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D204B6A0D43
	for <lists+linux-pci@lfdr.de>; Thu, 23 Feb 2023 16:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbjBWPpX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Feb 2023 10:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjBWPpW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Feb 2023 10:45:22 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294EC55C15
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 07:45:21 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id j2so10844524wrh.9
        for <linux-pci@vger.kernel.org>; Thu, 23 Feb 2023 07:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WUtJHy11n8Y/rq9v+tVThHOQuEU8nOltQBq6+LKXmIk=;
        b=V1VQBLeFVTmxch5HEcztI6KEJGkyu1+nRlw56ftIe1im+aJWKgbqYdAczH9MK4nC2m
         VRJKqGb1sNoAUU8J+HpwV/DWY162iNiiLL77tJDM36JkfzuRBNGbVcIGcu41RN/JpyF7
         b/qNt2HrhUeVDeuRZZkssDz7xlFAjQ197Ip9bQIKM/O+jnUetREpkeJlbtBRPt2Cz1LJ
         lxb8nUSYSBGTb20p4Q0SjRsuITeloeoW3tHqnuL/AnB1guCJZ5shwQQeWDI5VQKyIHlF
         GYaGjPJji34I4D5O5q8mWakY83vQYhaAFtWTJ8yJFnWWBZ4v4ULq0OoA8ipwMjzpn+28
         Gokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUtJHy11n8Y/rq9v+tVThHOQuEU8nOltQBq6+LKXmIk=;
        b=Hq4FGXEZ0gx8WxOayCjjGKbkf/1qYErwTIV03xT2DB7RqMM0SutBzPlQtv16HmYlt/
         wyqkZT7isfQ2PfrEpicv1WTrFek7b3mrorcWphTU0VZOnYX2mXGTmS5I/TzHfsUcj/mS
         LwXctQSwnh659pDko4iwJw6hecsKi+Qa7+7Fh0XqLucqc1d8F/p22Hr50AznkUlJBdAw
         bLTAvCeJCQhWWji3NoHW2g2z03iMWq18tz+R+VEUp4X0afs6go729aFf6XeratYUA0O0
         ocmOzuuY0OWcWOiPjgwhlVBFn417OEXeZQX4h6uFuzQdg7pMeiAjkUhLJCYK5Yn/3NO3
         rFXg==
X-Gm-Message-State: AO0yUKVGnabtmedNIf3NCUCplyrQxdc/oAXP8nC6esRWLl8p50zeKmnP
        4L4QKcgFVrLDL43OZw2kTH4x/A==
X-Google-Smtp-Source: AK7set+vIXFCFewCWF4qBdv5jm6siVTdfVVno5o1udTzlHH2yBZRGnoaUdEWRd1WBIcsio02GMoW9Q==
X-Received: by 2002:a5d:4610:0:b0:2c5:561e:808e with SMTP id t16-20020a5d4610000000b002c5561e808emr13069275wrq.12.1677167119643;
        Thu, 23 Feb 2023 07:45:19 -0800 (PST)
Received: from myrica (054592b0.skybroadband.com. [5.69.146.176])
        by smtp.gmail.com with ESMTPSA id t6-20020a5d4606000000b002c55306f6edsm13876488wrq.54.2023.02.23.07.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:45:19 -0800 (PST)
Date:   Thu, 23 Feb 2023 15:45:20 +0000
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, darren@os.amperecomputing.com,
        scott@os.amperecomputing.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH] PCI/ATS:  Allow to enable ATS on VFs even if it is not
 enabled on PF
Message-ID: <Y/eKEMo1moXt3pPP@myrica>
References: <Y+4PmJb2rBGMhS1y@myrica>
 <20230221154624.GA3701506@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221154624.GA3701506@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 21, 2023 at 09:46:24AM -0600, Bjorn Helgaas wrote:
> It's weird to me that the SMMU is between PCI and memory, but the
> driver seems to insert itself in the middle after PCI enumeration.
> And maybe even after some PCI device driver binding?

No this shouldn't happen, because device drivers expect DMA to be
operational in their probe() function, so at that point the IOMMU must be
configured. The core and IOMMU subsystems enforce probe dependency between
the SMMU and the PCI device, using links described by ACPI or device tree.

Thanks,
Jean
