Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B8F10C43C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2019 08:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbfK1HIs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Nov 2019 02:08:48 -0500
Received: from mout.web.de ([212.227.15.3]:38347 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfK1HIs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Nov 2019 02:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574924919;
        bh=AS07LnF2cF68ZWeFvVUCs6ObVlC4KunI8AEQAN8PYr0=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=sE+mqH0+Xdyr3r/rNpnjVHjJaa0P6epoC4HE9xWLJZnbS7S7h4xS0HW2zkRd0sbqK
         6Prl+b5GUTj8ectd5goaKv/nu+HoIPBHmN1IFp1Ky57B2BI3A4CitDZFZPDBCa4UxX
         lFStdV4KOpXv2CSPezAj9hhq67R3Y3Cd5f1OEdpA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([78.49.104.135]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MTLwF-1iPOmu2aet-00SLMG; Thu, 28
 Nov 2019 08:08:39 +0100
Cc:     Navid Emamdoost <emamd001@umn.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
References: <20191125195255.23740-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH v2] PCI/IOV: Fix memory leak in pci_iov_add_virtfn()
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <64f48c0c-97e9-bdf0-14fc-ae126603ee51@web.de>
Date:   Thu, 28 Nov 2019 08:08:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191125195255.23740-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:YlOYjl23BNH7H9oV/9C4U+TRlgy+I5HWc4uvHBjQOLP+ajm0fBp
 eIO6SGRDFfr6qZc18r7RuFQQLZ9RV2o8Tv22P6n8JPA41ksQEqNRy0vW9BqfjDcppQ6owlb
 +ybVHoCVI2vv6rYSFW+uDLKYblLoH/dEYs1RnKJtcNlvLUy4jL4/jq74x5PfrqJ38L+b+gB
 ipRTzmLJcOSgfEnBRytXQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DF/J/gU12Rc=:deiM9OQ3bMbniffgpS+Xqr
 br4qbRRrMI1ath+BZfzvixyyL5paMkVCqT1pSaYOsZB3aogjTylaBiC1OJcFrnd14uYMwqpHN
 kqoD9uOvIE+2fA6PTthfkdeIn5TnOJGz1z4MqgB0epbfXJa82j1TzB/g9NVBE2ewICIDXSOjw
 9oKCgwbvTjFeJUZJyOpz9rJ1zrnydIajyDntbEEZvdZ9Y4CD+pO5JrUoatRRN6010gR9pqtYm
 ulwzC5So/ZNSKWppAszKo4Ih/iHkVGs07QUUp9DZwH3kJkE58o/wXQP/Y1qGrfXM4ZDCCIjfk
 CdEnToOS24SI1mFBwp6qWjC2WPTxkb0JXIvAi2VYC6Oq4kxi8+/yTp6W956kwIIx7UoZrIA1M
 GOiVf0JmX4GkmMregrc0N5EiP9Ch7nhP399jHdl1bQ0wdBcIteHBYrWHYMZiN370+PGW3UggC
 bXu7dX5bERAR0atRiounISN3gKGTUBXDe2hGBnBzgOzsN67EJLB6/Ka0WREnW1/IGu4UC5gt0
 rR4ucqwPcBB413bjx25yfk2Vdg/zdxgmT6a89RJ/cHrDDkpR2+5z0+RbIz4FCvVNdXOgp47e3
 jRvFDe1yj3Y7ppj4leYegVX1+2tN5puEqUHl5lON4zdnDoy9I23y3+hLQxp5mK76QHp4utAwE
 qS3TQvc/+SIqHGD1nWZIs+ivHtBBny+1c1z/yjvFo/ngwawkIPtH1F3ByVfaOCZxL5HjJ7Std
 pDtAE3r16fVgHP1PR1b+P27ZAMkyf0C+A2xyUC/eq49x/4UX0ZAH5QNXnr8m/Z4C3Q74N0TNC
 hphekItKDxir0QM/lSgSBqvRm7AqDivCrEU9rCsIUElNnCLoqiCUdKrtmtPu3C0ThLRBulCSp
 DRUwY46jklnT/HVFVV3hZnY52lULVkThLRqN/78KFLrl0PUm8vlZf9bamdU/LhIhnPntTSN2p
 r05xfpV3gMEozKRG4PfTy1b4r79NkZkaMOTFFpTGX9/Uy5901sr9wDMyh0Exui/0kLmBGHzkn
 aB/kGnB2h58WeekJiG5YTMuqa8jaeGrMXowYq32qDbxuC2C9GWiE98BFT42Oemks81jvlH0av
 CdJaCugvwG1k63uKSD8yXhh5YLTwGvytOYavrVaL6lS5WxRMR9qpIncQ2++kLwlL1Ql6yb10Q
 MUlqBuqSTo/1587gYkaqvAseFqFJFZfr4yVFaeO59b9IF6Wbrj4jFna5UpUA2pH9TJs9mijN0
 RNDdgn6sBAvilVdWmnJzwevW3jU1v2v3Sg9Egi/db/C30OBNUYrb2OsTAT40=
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> In the implementation of pci_iov_add_virtfn() the allocated virtfn is
> leaked if pci_setup_device() fails. The error handling is not calling
> pci_stop_and_remove_bus_device(). Change the goto label to failed2.

Would it be nicer to rename numbered labels also according to the
Linux coding style?

Regards,
Markus
