Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC168A015
	for <lists+linux-pci@lfdr.de>; Fri,  3 Feb 2023 18:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjBCRPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 12:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjBCRP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 12:15:28 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9769D5A7
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 09:15:24 -0800 (PST)
Received: (qmail 32684 invoked from network); 3 Feb 2023 17:15:23 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 3 Feb 2023 17:15:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=message-id
        :date:mime-version:from:subject:to:cc:references:in-reply-to
        :content-type:content-transfer-encoding; s=2018; bh=ggl3wDMwxRQu
        E7GebVROC5jrBccyl7QBS7ttNF5Pvpw=; b=gatIzgkuBCJQroRliw1BWu3TZp9O
        OxjfdQrcQAHe1RnPwFsdeSJnS2Lxd/nOYCSEiRSYhJZXQ75NUBWIuLoBP5Yp8Xc8
        VzIuaceWQXZ+fBdmASec8xWtIJdHt6VDh3x6cxqcFGl35JqWxFykyftEXbfkL26G
        T2qlrphp8381Qq0=
Received: (qmail 90973 invoked from network); 3 Feb 2023 17:15:22 -0000
Received: by simscan 1.4.0 ppid: 90589, pid: 90886, t: 1.2471s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 3 Feb 2023 17:15:21 -0000
Message-ID: <aef1d48b-cfc2-1a5d-d26c-deae85875d43@openmail.cc>
Date:   Sat, 4 Feb 2023 01:15:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   equu@openmail.cc
Subject: Re: [PATCH v5 3/3] wifi: ath10k: only load compatible DT cal data
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org,
        linux-pci@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, kernel test robot <lkp@intel.com>
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
 <20230203104822.361415-1-equu@openmail.cc>
 <20230203104822.361415-4-equu@openmail.cc>
 <CAL_JsqKq1Yv+svKMS3R=TmDui1VJEjinoPFoDAAgr8tBbV1aSQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKq1Yv+svKMS3R=TmDui1VJEjinoPFoDAAgr8tBbV1aSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> I think this can be done a bit cleaner and like other drivers. I see 2 options.
> The first way is use VID/PID compatible strings and don't set the
> of_node pointer if there is a mismatch.
Where should I do this? In pci_set_of_node() from drivers/pci/of.c?
> Upon further thought, why can't you decide all this just on PCI
> VID/PID? The giant switch statement in ath10k_pci_probe() could all
> just be struct of driver_data from the PCI match table.

I cannot decide all this just on PCI VID/PID because PCI VID/PID cannot tell whether calibration data are stored in the device (like most expansion cards) or not (for example, in an NVRAM cell referenced by the device tree).

