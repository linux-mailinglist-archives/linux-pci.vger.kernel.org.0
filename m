Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3268A829
	for <lists+linux-pci@lfdr.de>; Sat,  4 Feb 2023 05:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjBDE0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Feb 2023 23:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbjBDE0O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Feb 2023 23:26:14 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EBD2E833
        for <linux-pci@vger.kernel.org>; Fri,  3 Feb 2023 20:26:12 -0800 (PST)
Received: (qmail 12022 invoked from network); 4 Feb 2023 04:26:11 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 4 Feb 2023 04:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=message-id
        :date:mime-version:from:subject:to:cc:references:in-reply-to
        :content-type:content-transfer-encoding; s=2018; bh=6FQ/mWs8MPD/
        ilIHOtvhkUEM9lfOwINQv/6BuHhx3QA=; b=B8XzNsbwoWQ7v6iTvZYjmGnjlFkY
        PahFJJX66+2FplakSuLo7+P3nqy736o1CjQy6xAXFCp8NUkpSjDJJ0faj6QD71zA
        qZiZYWbE22uS2VLnJfYQ3i7837/E2/HdtXofxgF3FatRO2ICDyRzdVSwl/+nlwnv
        6bwoMT9ko4g8vEw=
Received: (qmail 90372 invoked from network); 4 Feb 2023 04:26:10 -0000
Received: by simscan 1.4.0 ppid: 90330, pid: 90365, t: 0.3330s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 4 Feb 2023 04:26:10 -0000
Message-ID: <0369d0d2-cb2c-7310-4f33-dc8da52816ef@openmail.cc>
Date:   Sat, 4 Feb 2023 12:26:05 +0800
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
 <aef1d48b-cfc2-1a5d-d26c-deae85875d43@openmail.cc>
 <CAL_JsqLbGBQcxDQSbsqFyE2CR3VH=61NtZvU2YqE1visdUZXCQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLbGBQcxDQSbsqFyE2CR3VH=61NtZvU2YqE1visdUZXCQ@mail.gmail.com>
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

>
>>> Upon further thought, why can't you decide all this just on PCI
>>> VID/PID? The giant switch statement in ath10k_pci_probe() could all
>>> just be struct of driver_data from the PCI match table.
>> I cannot decide all this just on PCI VID/PID because PCI VID/PID cannot tell whether calibration data are stored in the device (like most expansion cards) or not (for example, in an NVRAM cell referenced by the device tree).
>>
> For a given VID/PID, you could have calibration data in DT that you
> want to ignore sometimes and not other times (because the compatible
> is wrong)?

Some devices will change their VID/PID after applied with calibration data (e.g. AR922X will do 168c:ff1d -> 168c:0029), but most device trees only record their post-calibration VID/PID in their compatibility string.

Should we match such device against their pre-calibration VID/PID only, and break all current device trees for them?

I think we could add these pre-calibration VID/PIDs to the ID-list of the PCI driver, but had better match compatibility strings against drivers, not devices.

