Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79D46FEC57
	for <lists+linux-pci@lfdr.de>; Thu, 11 May 2023 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjEKHHe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 May 2023 03:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbjEKHHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 May 2023 03:07:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5F030C5
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 00:06:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f435658d23so21702525e9.3
        for <linux-pci@vger.kernel.org>; Thu, 11 May 2023 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683788807; x=1686380807;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uIcWuLsvmopxNqnqJDp9shwq0Jdw37qdS0lcw8bVdic=;
        b=ycpeV+yVsSbxBLOUN79yLRjIrWyZ1UvlH3EIkpTwQK2p4gMxr6g6dqro38HZ/+R77E
         +luQnv+aHBa8YS5usgays2YhAsyDQEpMSNJhr+3WfDmU/ctRqEAc9vsJ7zE6Pd+plKkO
         cKfD1zfNmYZqSIJJI/UTy6GiIpUIu609x9EwF/GK0ppFTUKxEHEJ0YQZoHrwDupKkV3H
         KJpCM0K+7BtER+PE/eMNRRVlqD3kIWr9ByIs6mgVcBk4j9ImjG8vnJOem1MfQt8cjfDq
         gTJ6VsTsF2Q1nTqGBnfVHJOta874HvcVNE/qESKdFGjjzc51TwjwCa5HtvfZACgH5oUO
         AVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683788807; x=1686380807;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIcWuLsvmopxNqnqJDp9shwq0Jdw37qdS0lcw8bVdic=;
        b=GHG12aeVOS6mwbPb/xJesw6IMU7z/tfknf/7iE1v9ozmqLx3n33m3+bfe/i8CZ2Nqi
         7kuiwOjmk6+azdvLkOl0LnbWyXb/df0aNkEfTXhzBDs8adDfUTdwZPATkUZonc+n6eoh
         K2CeMXWbLd4KM4nh1CW2gS8U68vSAn/cIbWr6zV9/mV6BeCFQLggRY2Dl5DXRXDova9T
         AZH+5QGxFtzLaXCBJxB1M8sVzne2cb7UZ8tVznXwuZskGSjkzApIAONub1lo5RKHD4QE
         3AJu8omLdaGp10nAdp6A7JgTvkNehStgCW3Mw+AlZSCunMitrOTKGJ8YsraiZZHZckP9
         WNAw==
X-Gm-Message-State: AC+VfDwfg4cdGlwkb39hYZ+wEOE7bYauNm+PAzPtSveNriwWWc9PorIr
        atqlcQYCRBvKeIhJdDTkIL4XZg==
X-Google-Smtp-Source: ACHHUZ7hOcdwBFm1sYha2YbMHDckIxJuYC0atDMrBhdTB//xTqsxFg5ia4bmoOpOuMORz9HmP6yWUw==
X-Received: by 2002:a05:600c:b44:b0:3f4:23a4:7a93 with SMTP id k4-20020a05600c0b4400b003f423a47a93mr9294986wmr.25.1683788807559;
        Thu, 11 May 2023 00:06:47 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l2-20020a1c7902000000b003f195d540d9sm24508171wme.14.2023.05.11.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 00:06:45 -0700 (PDT)
Date:   Thu, 11 May 2023 10:06:40 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     dlemoal@kernel.org
Cc:     linux-pci@vger.kernel.org
Subject: [bug report] PCI: endpoint: Automatically create a function specific
 attributes group
Message-ID: <95d23290-496a-462c-87c5-944df1e20ba1@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello Damien Le Moal,

The patch 01c68988addf: "PCI: endpoint: Automatically create a
function specific attributes group" from Apr 15, 2023, leads to the
following Smatch static checker warning:

	drivers/pci/endpoint/pci-ep-cfs.c:540 pci_ep_cfs_add_type_group()
	warn: 'group' isn't an ERR_PTR

drivers/pci/endpoint/pci-ep-cfs.c
    532 static void pci_ep_cfs_add_type_group(struct pci_epf_group *epf_group)
    533 {
    534         struct config_group *group;
    535 
    536         group = pci_epf_type_add_cfs(epf_group->epf, &epf_group->group);
    537         if (!group)
    538                 return;
    539 
--> 540         if (IS_ERR(group)) {

pci_epf_type_add_cfs() does not return error pointers currently.  Which
is fine.  Presumably it will start returning them later.  But could you
add some comments next to the pci_epf_type_add_cfs() to explain what a
NULL return means vs an error pointer return?

    541                 dev_err(&epf_group->epf->dev,
    542                         "failed to create epf type specific attributes\n");
    543                 return;
    544         }
    545 
    546         configfs_register_group(&epf_group->group, group);
    547 }

regards,
dan carpenter
