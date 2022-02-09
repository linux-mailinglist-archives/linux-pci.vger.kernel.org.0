Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806764AFDD3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 20:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiBIT5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 14:57:49 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBIT5s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 14:57:48 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3B1E067869
        for <linux-pci@vger.kernel.org>; Wed,  9 Feb 2022 11:57:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w20so3137134plq.12
        for <linux-pci@vger.kernel.org>; Wed, 09 Feb 2022 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hLa+EiH1mRG9f1fQTD6dnIZH6dFitXQQk4vxZMPiC5c=;
        b=KX8AdbYmDS6spCCkdzMJ7tZJv5GtJ1yMkJcpmSpW1TfCRtSAnNQtHSMa4mPauEi/Cd
         +MLAjE0FY3+SJWZvR4HwSBSax5Hqg4pXKqJ/idqJG8nDynA1AsxQJpTKolXkM86ZpzU7
         ki/MDoBo1aeE5Odl8CYDrDcAO19oeCWrrOmQxrbIcqw7Fdcqtmv81Eax8I1LRRfHCsgY
         x2VvrtSCBcpwbVqKkOdPql2XNRQjEUyX1omLLffMH6H6QhQhX1Ck3H52H1nan8+jCpNh
         vf2/wuHA4n9yW+x/PpSvpKtY1P3Ub3+fzkAzDOgV78LZvHrBDurXd+d4HTq3jzSBhucc
         WgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hLa+EiH1mRG9f1fQTD6dnIZH6dFitXQQk4vxZMPiC5c=;
        b=4TDciejzjVN/ZkRbOIk0T5iKspJTPJ3k2fk3R9U6USPskkwLKc0w5I7yp4ryfCupvo
         HqFFWLz43cOJFqjD/mIu1PSAJaZPn+oBm4sIFFKVGizPFZC7zeK+hEGKvZH2GKRHm+Sx
         06f/ZM7O6APJr5I4pzj2Y3knoLCxJ7A8+37vXtDp53PnqlAz62RIvQrnb7qrnuhfLmxx
         myhIfIW+FuXhBax9JUB5jRfW6MOyzRtmxC8ap4SBv6HhT9bH4UE6tUl36lI3v6nQ8AKP
         3KX3Bb9wl1/AMHRW++wjbq/NHtABa3jUsOyH877pNP5j0rxoAGnOSjOD3X++v0z74gKM
         XvIA==
X-Gm-Message-State: AOAM532lOlONuEvmUKMfyHcInj5xtlWcyxJgwxrpGNP4E/EyjUroopgZ
        XQZlFrxC1m30JNH1rByyB1KVfVIyrvr7JgXWVikh3g==
X-Google-Smtp-Source: ABdhPJy1CZ+jtneOWBZEOWg3IGJXU0RLO7anSCnJ9xepD6AnWwHom3tpnlP5xqHgKfePw1ryjZF96fweobvsuAxF1rA=
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr3830543pls.147.1644436669601;
 Wed, 09 Feb 2022 11:57:49 -0800 (PST)
MIME-Version: 1.0
References: <20220201071952.900068-1-ira.weiny@intel.com> <20220201071952.900068-4-ira.weiny@intel.com>
 <CAPcyv4hYAgyf-WcArGvbWHAJgc5+p=OO_6ah_dXJhNM5cXcVTw@mail.gmail.com>
 <20220209101320.00000473@Huawei.com> <CAPcyv4g2nNHKPuYVOEH3TbJtCiB1rkRNCVbfDWHnWkotvTAcJg@mail.gmail.com>
 <20220209165756.00002841@huawei.com>
In-Reply-To: <20220209165756.00002841@huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Feb 2022 11:57:38 -0800
Message-ID: <CAPcyv4j9mEOn_sJSwX+rY_6wFjuU_JB7e075_n_Q5sfgiGsqew@mail.gmail.com>
Subject: Re: [PATCH V6 03/10] PCI/DOE: Add Data Object Exchange Aux Driver
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     "Weiny, Ira" <ira.weiny@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 9, 2022 at 8:58 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
[..]
> > It just seems an unnecessary hunk of code for the core to carry when
> > it's trivial for a client of the core to do:
> >
> > task->private = &completion;
> > task->end_task = complete_completion;
> > submit_task()
> > wait_for_completion(&completion);
>
> OK, we can move this to the callers though function obviously will
> also need renaming - I guess to pci_doe_exchange() and now need to take a
> task rather than the exchange.
>
> I personally slightly prefer the layered approach, but don't care that
> strongly.

Like I said, you and Ira are holding the pen, so if you decide to keep
the layering, just document the ontology somewhere and I'll let it go.
