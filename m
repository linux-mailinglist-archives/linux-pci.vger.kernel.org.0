Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FDA68A22F
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 19:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjBCSpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 13:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbjBCSpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 13:45:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C664DA0E87;
        Fri,  3 Feb 2023 10:45:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 388B9B82B9C;
        Fri,  3 Feb 2023 18:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DAFC433A0;
        Fri,  3 Feb 2023 18:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675449925;
        bh=p1X6ugmSgzmfWKkwB9BSvV33mOB8R7h4or5Aj+xg7bc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ebfuPC0zAOIWh3D49j9KohnB21VPXiY1L3ZzPbzjX3HtAC3/jmTixaUTvCK5LlE/w
         IFv5eA7NMvzdpYw/XWRA1TNAa9JfhACQOFYPMyWJl7ibTW2coQMNQquLChIf8pqoRp
         WqaZ4tTbCYQo3dkqEwXm7SEWtuhjvIUF5YPWRs4DBPtYVSrDfUl0JjVt3r5j1ZNLm0
         JvexY1gwJF9PS7gLgeEno/KNnri9P0oaHEuPyR+aPZ8IePXXSfRGmscuGIpcHBCGsQ
         PaLU28qfccw01YIYddw5tUMVOS4zR2mbYcokJ3/u/9yHp45doPjCi7VUwyc8f0ABlL
         61/QRB9V1pMOQ==
Received: by mail-vk1-f180.google.com with SMTP id l20so3009076vkm.11;
        Fri, 03 Feb 2023 10:45:25 -0800 (PST)
X-Gm-Message-State: AO0yUKV7QXeK12+6H1Oa53IYEeW//828gifRoZ/HJS9EZ4GRM3xviorC
        hkmaghQe0u/banfFvZ/KTZxCQnGSrF0ETJWAFw==
X-Google-Smtp-Source: AK7set8aljTXKYnSleLN5uKaZefTJzwSLTnGjjUc4dff/Ia7so1d0a9zhKmWJNIhVMP8fr42WVgEKFBt3+beg59W0e8=
X-Received: by 2002:ac5:cbf8:0:b0:3d5:d30f:81c2 with SMTP id
 i24-20020ac5cbf8000000b003d5d30f81c2mr1617935vkn.14.1675449924803; Fri, 03
 Feb 2023 10:45:24 -0800 (PST)
MIME-Version: 1.0
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
 <20230203104822.361415-1-equu@openmail.cc> <20230203104822.361415-4-equu@openmail.cc>
 <CAL_JsqKq1Yv+svKMS3R=TmDui1VJEjinoPFoDAAgr8tBbV1aSQ@mail.gmail.com> <aef1d48b-cfc2-1a5d-d26c-deae85875d43@openmail.cc>
In-Reply-To: <aef1d48b-cfc2-1a5d-d26c-deae85875d43@openmail.cc>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 3 Feb 2023 12:45:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLbGBQcxDQSbsqFyE2CR3VH=61NtZvU2YqE1visdUZXCQ@mail.gmail.com>
Message-ID: <CAL_JsqLbGBQcxDQSbsqFyE2CR3VH=61NtZvU2YqE1visdUZXCQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] wifi: ath10k: only load compatible DT cal data
To:     equu@openmail.cc
Cc:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 3, 2023 at 11:15 AM <equu@openmail.cc> wrote:
>
> > I think this can be done a bit cleaner and like other drivers. I see 2 options.
> > The first way is use VID/PID compatible strings and don't set the
> > of_node pointer if there is a mismatch.
> Where should I do this? In pci_set_of_node() from drivers/pci/of.c?

Off the top of my head, I think so.

> > Upon further thought, why can't you decide all this just on PCI
> > VID/PID? The giant switch statement in ath10k_pci_probe() could all
> > just be struct of driver_data from the PCI match table.
>
> I cannot decide all this just on PCI VID/PID because PCI VID/PID cannot tell whether calibration data are stored in the device (like most expansion cards) or not (for example, in an NVRAM cell referenced by the device tree).
>

For a given VID/PID, you could have calibration data in DT that you
want to ignore sometimes and not other times (because the compatible
is wrong)?

Rob
