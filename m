Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7706C3CD5
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 22:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjCUViA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 17:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCUVh7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 17:37:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ECF46AA
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 14:37:58 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id ix20so17486227plb.3
        for <linux-pci@vger.kernel.org>; Tue, 21 Mar 2023 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679434678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chjWV3Ku6pCaFLckW3bDFmDzfpJqVSH7EzEa6O4PLlc=;
        b=YwV3nWYwA8DTIJ3Wkxh2s4AenBfFJMaxxtL2hRhD8QtPI4mEojP3u8NKnKWDP92F6t
         I8wmliVKLXFJHspzGa9OoxfuTtvHf9A71gsZ9cD/TNbZ2r2pLDIfV0QQk6oqybGU2AI3
         waiBXsZRKaqskk2pQEO+zpux2VPJ8DOLsixjW0YHoJ3TNybCWEMYicEdTu4uI4Iz9wZy
         8XBeCyIWALtTn8saKjvcomgC18foBI1rLwrdXJ7iyMMiuMp9XoF691adHTSJRUCuUi5Y
         hLGiHcj5mnT6VHb5NQFMxrFcioEQnjJ5p5nXm9TDnb9Olvg/MHb/V3O78+evnQ6RHdBa
         qc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434678;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=chjWV3Ku6pCaFLckW3bDFmDzfpJqVSH7EzEa6O4PLlc=;
        b=nJl0t8x/n3k+MSmRynAdZrzQ8a0UFpIFOI1tJPb4o7Z+5LR/ahHBioqKJDr+S+pNRE
         2AudEoazv2JEogsk0oRw9+aL01T8/CjH9td7LZ8H9vi11wDRBPSuxEL/GtKRmdos1y8w
         0VaxQRtjoiOBE5GI4cvSeuVaC0SrnwhuL78h8GbcQZSqUsJblbDbRyOeUIDmXWZLWRfk
         Y9tIUGnxfrYokZySbPNOG3o9Os96H0ZBsibEsty0A0Eh6d8D/qUJ3aGwNWJuVqF110KW
         DAyjsEhS0q0aU8AcyDB5MrDoPtgj3DWJoKHndlLh6rFYHGaUXxRbdeOrweXsBPu64rB9
         oI6w==
X-Gm-Message-State: AO0yUKXFChlC6sBs56bf0vGQ0Z5Q6ZmpwSswqZ1kWdJ1cEn5NyXddmjK
        SOZHMi2zy8bjZHSBYhd59yY=
X-Google-Smtp-Source: AK7set9a9hBbuVMxJTKHOlbrLMvV5GLy9+pmGAV5YKHZxSJRN1r3+AfIIQG0vx0wa3kZLb+YL+S84Q==
X-Received: by 2002:a17:903:2443:b0:19d:e11:32de with SMTP id l3-20020a170903244300b0019d0e1132demr603763pls.34.1679434678124;
        Tue, 21 Mar 2023 14:37:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k20-20020a63d854000000b0050b026c444fsm8394227pgj.62.2023.03.21.14.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 14:37:57 -0700 (PDT)
Message-ID: <b6e076d4-4014-edfc-edba-284e26d4ca0c@gmail.com>
Date:   Tue, 21 Mar 2023 14:37:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 08/15] PCI: iproc: Convert to platform remove callback
 returning void
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     Rob Herring <robh@kernel.org>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
References: <20230321193208.366561-1-u.kleine-koenig@pengutronix.de>
 <20230321193208.366561-9-u.kleine-koenig@pengutronix.de>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230321193208.366561-9-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/21/23 12:32, Uwe Kleine-König wrote:
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks.
> 
> The iproc driver always returns 0, it's just a bit hidden. So make
> iproc_pcie_remove() return void instead of always zero and convert the
> platform driver to the alternative remove callback that returns void and
> eventually replaces the int returning callback.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

