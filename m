Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3CC788852
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239709AbjHYNUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245127AbjHYNUY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 09:20:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042F211F;
        Fri, 25 Aug 2023 06:19:54 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68bed28818fso786695b3a.2;
        Fri, 25 Aug 2023 06:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692969592; x=1693574392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jm1YKY3VaaJ5zdUdj+/pYaFFTQIbU7C83g2TaC9vkM8=;
        b=MDIM8RsL2wUsJ8nbza4vdgeTeSujOQseME86c0z24mKv4o+/h0PY3cM3exs6luiv6M
         EiSQOgRG/QLIC2dL+g2+mJ9YhsxCFtALCgX8XZm2sNuGq2INucrNPuneasGZjQhSLOZE
         WRk3UzUYL5sxwlBC/VowyLca2XlPBTPzbhLKHyYJlABS6reEUiDQirWbeyf7sQM38xzH
         g0gc6g2rn6mgPDNVMHbf1iWhWNkEhgiiE1/EE0evx/Wpzv+KBtOAj87zw77Hf4EdhX9I
         CBNdgbeSPKx0NPiAAICs2Uqwmvw4Q2ptwEiS2LGULOoKCe+uL7glJEVzIvT+WzJHModn
         T60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692969592; x=1693574392;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm1YKY3VaaJ5zdUdj+/pYaFFTQIbU7C83g2TaC9vkM8=;
        b=SFyhbp50h9ZJ7stRx/xrVSWedpSD2n27p/vOrfn++tTf0sqb/8HwacaBaUsK5dpknK
         ZVTpEjAQSRqeklZA9ZammaCjOZu0ztH00naerFNgUD/YE0d10U/MSAPkiEIeRFSUlkMO
         4gBckovg8U3IKCVhYRgiaSLSPAgGcAMrZO4OPhP2ZuMLSFdBXc29nuSJowDjFP77gfp0
         CfIdBAGKT/AwhLxjjbiCK1BXo9XEJ6vrsOW7gaD4LI0QAOcf9TPDWAXu0uwNbccUdQuI
         6uYY5CgiKu1O0gyQ3Z5ddj3ZBB4TNv9ZlYkfwWkhIn261+tw00UKprkx1CTBFbbrzMq3
         6mRg==
X-Gm-Message-State: AOJu0YzxnAloTxWHBg0yROhbpgFm04hCgsvZU2bd6BWzBaA1eR3gT30z
        vLPxmUA/Dti17hwKFYttEUQ=
X-Google-Smtp-Source: AGHT+IFEBzFoEUvO126WFowb/fjH3owmwbxsnZQDgvgR57M7MdhuRuJ0Jmbrn2ol+AEdksjMGtIhmQ==
X-Received: by 2002:a05:6a20:199:b0:12f:dce2:b385 with SMTP id 25-20020a056a20019900b0012fdce2b385mr16158505pzy.10.1692969592421;
        Fri, 25 Aug 2023 06:19:52 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v15-20020aa7808f000000b0066a4e561beesm1553233pff.173.2023.08.25.06.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 06:19:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Aug 2023 06:19:51 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Roger Lucas <vt8231@hiddenengine.co.uk>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/14] hwmon: (vt8231) Do PCI error checks on own line
Message-ID: <4cba29bf-ef8d-4df2-b756-29b2e44100ad@roeck-us.net>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
 <20230824132832.78705-7-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824132832.78705-7-ilpo.jarvinen@linux.intel.com>
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

On Thu, Aug 24, 2023 at 04:28:24PM +0300, Ilpo Järvinen wrote:
> Instead of if conditions with line splits, use the usual error handling
> pattern with a separate variable to improve readability.
> 
> No functional changes intended.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Applied.

Thanks,
Guenter
