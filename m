Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953BF78884B
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 15:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbjHYNS6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245066AbjHYNSc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 09:18:32 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B92123;
        Fri, 25 Aug 2023 06:18:30 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68a3ced3ec6so776043b3a.1;
        Fri, 25 Aug 2023 06:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692969509; x=1693574309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSWvX3xXkr8BBKCu/dIZvMwN69hfVQo3YQSgH4sKVJc=;
        b=A2DLtAM9nGfLlGpit2tw20W0RsL1wfsLb2pK+PFscb8IdawXDj8FCFWy3gCX8PakgY
         91Zxkn50U7vW6yQrnrtN5fIEltkv86QidGtowq5OfeBV1ifj+dUkIK0jz2LVJ80kS5sd
         JTxoVd724aUolpOxLhDQXHST2QLNaFeplYtxJiKJ0NkqLq+cHaeuPhJIRAoMzU9TlnSI
         EXUzU/PLVsaSt7O3FSZjup7zaBDIKQsGsSZil94n7hN20WrY2CxC1NEoCKTm7xFBGTIe
         nMzrow3H7TWiFDHWsGHGz9TMk9y9yvRmGS4seyoIYYS+3LkKI/pG5BXHFNUwG0FNYGFJ
         L9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969509; x=1693574309;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSWvX3xXkr8BBKCu/dIZvMwN69hfVQo3YQSgH4sKVJc=;
        b=ZAbuIxP7itj5gYlswXwRyIC9XTSDAWhyvSNTnRc/CUnf3dSQNv4iIF7kuScnZgbTFB
         BOycMOgnYwsl6cORjhs1/5KSTOdL4rZ9WNJJWExBA5MPyvqjo0TKqIU0RnIbTjYoF+3v
         mKvo3qxwiTxXPbjl4fQk7oH1yuMQyb96/8RCWhrW33ELUe9x8eTYyvmRUXoMIKctDiBn
         +IGSVc/ikjZnS5K4wUvFWZhxXl/jgBU+mf29cyvZrwqB+kpFz1RNE1BJaSRg0JEwAdC2
         uQuSzO0CaBte1I7fwDI7+y/tBGF0/b6Gf41xGASR/fnIz8qiZZIQQK/drTrhbYh6QXLv
         b1Jg==
X-Gm-Message-State: AOJu0YxgnaPB32D3lFRKJjMk/FCwKU3pCOV4ZE+5XCdXHWDillJPPIth
        4vCutlPigZDYk3Jd8gB1jpaeARbJYeQ=
X-Google-Smtp-Source: AGHT+IF84wEgtinM8CQOZr7kYRc5qsrQVNvl2GQ5Z84k+kBaFrebCrPSd2NdEtXeaBKQwzT623hdng==
X-Received: by 2002:a05:6a21:71ca:b0:14c:7b3:9ac6 with SMTP id ay10-20020a056a2171ca00b0014c07b39ac6mr4535410pzc.41.1692969509395;
        Fri, 25 Aug 2023 06:18:29 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n26-20020a63721a000000b00564be149a15sm1504002pgc.65.2023.08.25.06.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:18:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Aug 2023 06:18:27 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] hwmon: (via686a) Do PCI error checks on own line
Message-ID: <849edac9-ac9f-45ec-bdfc-51cff9f3f81e@roeck-us.net>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
 <20230824132832.78705-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824132832.78705-6-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 24, 2023 at 04:28:23PM +0300, Ilpo Järvinen wrote:
> Instead of if conditions with line splits, use the usual error handling
> pattern with a separate variable to improve readability.
> 
> No functional changes intended.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied.

Thanks,
Guenter
