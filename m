Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D354AD04B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Feb 2022 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbiBHEU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 23:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbiBHEU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Feb 2022 23:20:28 -0500
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FF1C0401DC;
        Mon,  7 Feb 2022 20:20:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1644294016; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=A/gZ4I2W1aFDF/7HB6EFQWWvauCeg2zwErlsABsQdO7YXK3o6iwT75rOn9X6Jm3sz5eMhqmxEBxlBhref12Eb/REUm34PTohaSUjrhVUKQb6qJ3knwZhWihN/ryZGsjUko2fUBz6IgSMjMwSJ1Tf7yp6BXbopmZF9jbcobGHtEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1644294016; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Fd1dN+H9VpLs2Rn96C0ylDOWq0q9ugp5pJzIMQqGhXc=; 
        b=UCxIu+4iZdjV7OXZLMc/pMjWN7GvUcVk9cqQoM/ncGf+fHY6DBxO8mGvtRwPF4SUrhKUI/JRCJLirNKnajGufAneWwbnbkYnMQz2Hx9btOiG/WF2fdkMRxotVEkeXYV1/L6UDIiIqlPLQdvfMz3NeqtaLbkpbcbmkS9+4S5iiIU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644294016;
        s=zm2020; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=Fd1dN+H9VpLs2Rn96C0ylDOWq0q9ugp5pJzIMQqGhXc=;
        b=Z0bAkZa11QHSnDBoKchxvwAKwUtv30GQ7YYOZyf9jOOXhEqcXifJk9OfpEZD2mdH
        cLYmhP0qsH98apYNmyHFh3j3IpCAyJDHBon/KHo5/SdQuY46YjNv5G5MlsSOvaw6luE
        ADiPnpnTGMYA24Cn18X508G+QwRa90rb5aoEKu9w=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1644294015113890.2803542207891; Mon, 7 Feb 2022 20:20:15 -0800 (PST)
Received: from  [45.80.185.188] by mail.zoho.com
        with HTTP;Mon, 7 Feb 2022 20:20:15 -0800 (PST)
Date:   Mon, 07 Feb 2022 23:20:15 -0500
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kishon Vijay Abraham I" <kishon@ti.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        =?UTF-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "linux-pci" <linux-pci@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <17ed78f886f.d22c200668349.8594449941761827257@zohomail.com>
In-Reply-To: <20220207175613.GA404082@bhelgaas>
References: <20220207175613.GA404082@bhelgaas>
Subject: Re: [PATCH V6] misc: pci_endpoint_test: simplify endpoint test read
 and write operations
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

 ---- On Mon, 07 Feb 2022 12:56:13 -0500 Bjorn Helgaas <helgaas@kernel.org> wrote ----
 > On Mon, Feb 07, 2022 at 04:09:05AM -0500, Li Chen wrote:
 > > From: Li Chen <lchen@ambarella.com>
 > > 
 > > Introduce pci_endpoint_epf_transfer_data to simplify
 > > read and write operations.
 > > 
 > > Also tabify this file.
 > 
 > Thanks for the patch.
 > 
 > This doesn't apply cleanly on v5.17-rc1.  Please make it apply cleanly
 > there or at least mention where it *does* apply.

Ok, will send v7 which will be based on v5.17-rc3.

 > 
 > Please separate the whitespace tabification changes and the
 > pci_endpoint_epf_transfer_data() changes into two separate patches.
 > When they're mixed together, it's harder to review the patch.
 > 
 > > #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
 > > -                     miscdev)
 > > +                        miscdev)
 > 
 > Always indent with tabs when possible:
 > 
 >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=v5.16#n18
 > 
 > Hmm, coding-style.rst is unfortunately not very explicit about that.
 > 
 > But it's obvious from the existing code in this file that things
 > should not be indented four spaces, as you did in
 > pci_endpoint_test_transfer_data().

So, can I say space is not allowed in indentation? If so, I should not use emacs's tabify, because it will not convert 4 space to 8-width tab. I'm also not sure is scripts/Lindent or clang-format is a good
choice here, they do too much changes.

 > 
 > Your patch should match the style of the existing code.
 > 
 > > +static bool pci_endpoint_test_transfer_data(struct pci_endpoint_test *test,
 > > +                unsigned long arg, const int operation)
 > > +{
 > > +    struct pci_endpoint_test_xfer_param param;
 > > +    bool ret = false;
 > > +    u32 flags = 0;
 > 
 > 
 > > +    // if we ask rc to write to ep, then ep should do read operation, and vice versa.
 > 
 > Please use /* */ comments to match the prevailing kernel comment
 > style:
 > 
 >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=v5.16#n598
 > 
 > And spell out or at least capitalize "RC" and "EP" since they're not
 > real words.
 > 

Thanks, will do it in v7.

 > Bjorn
 > 

Regards,
Li
