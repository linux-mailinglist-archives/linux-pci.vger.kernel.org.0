Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7181228BE8
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgGUWWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 18:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgGUWWK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jul 2020 18:22:10 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B199C061794
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2020 15:22:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 95so335224otw.10
        for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2020 15:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XJulkHtLO+mMPWALlKYBY/bLhAhk7+2o/jlFimjEMOo=;
        b=wq6J6cpwdJBjI6mTP54hFwcwZMilBwGW7g+ttHAqjNONgm9zMMY+qa5n4XIV4ZGDud
         hjqL9l1q/tQuTVWRtbYT2Q6Ij9jLNw/qwJqIRZuK64usOBK9e3GMs1qiNPIFHgaJJiWX
         AI4uoOk4bd2suw7fiiIoP6yTVlDJoefdPFBQkxggmUJnHwr3kX4Z4wt1zCdYiLGkAmNu
         7iqkCW+xKouF7iQxSnrpxyhy/E8xnYJpgIImLxIj6816j1zUSgKK9CEyRCcNODM+riMh
         4kE0ni8Nysr5lhvWWscfp1Wd2mQ0etc1DNSRxRZd0LBpNHiA+86OfyUSPbhqYXA80qcc
         JfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XJulkHtLO+mMPWALlKYBY/bLhAhk7+2o/jlFimjEMOo=;
        b=qrdbp7eMC6mcGR7r26frlBDHjCD5Ju74ZVYpxL9jodCZqTHFK3b2BZOmE7bIpxLTXS
         xBoH6mIjmg4dKTjBPKzD1po5nAs2wQWaFkSwAWQ1afe+ncD6kDaKRkvrp6ScpV7tYSbP
         ojo9CI6P/jVsZWYWe8GbOXPlk9RRioqmYkPTLWJtAbCTSq/yoOEPnDpq9ArH41vrgsSq
         Py1w9sn6I5jQeDq9939DW9K7yI0Go3qJFqdH5rDbhCcUkHGE9PyjSG4QBmPbMG/YkZpt
         95z0/hTQ714OM+LcD7bABr8+moa6zLxwRlsnSL7ypNb984iWd2qTmRPcV3a2xxu5E4R1
         1H/Q==
X-Gm-Message-State: AOAM530mqabiB5XPxJbaHNlkwdRXQ+4mQzwNgkZmhyap/3K7NybC0RgW
        SbDQvrwpRnfUyEhoHqRpRyHePntIWD7qZUSAbPp0zNJEpX+VlA==
X-Google-Smtp-Source: ABdhPJw2C3UgvOyfxNDNaXmFy5DZqHcFCYH/Lco+saqJAhcLTU6w+S+TJ/rAY4Z9wwD1jbOrao+M8MK3uI1YaAMtzN4=
X-Received: by 2002:a05:6830:1093:: with SMTP id y19mr26763187oto.204.1595370128967;
 Tue, 21 Jul 2020 15:22:08 -0700 (PDT)
MIME-Version: 1.0
From:   Doug Meyer <dmeyer@gigaio.com>
Date:   Tue, 21 Jul 2020 15:21:53 -0700
Message-ID: <CA+GK6emiHu9kQZED05jRnT0+kK_ZTr=upoYn2AJwEvFTts7eUg@mail.gmail.com>
Subject: PCIe Enumeration w/o Provisioning
To:     linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone,

I hope you all are healthy, safe, and doing well.

I received an excellent suggestion from Bjorn H. to post my conundrum
here, in hopes that perhaps some of you might offer some suggestions
for a challenge I'm facing. Thank you for a bit of your time.

I've gotten started on a challenging ask rooted in the desire to
obtain resource box slot information (for orchestration) prior to
binding the resource box to a host. It is an interesting challenge
given the variety of hardware which may or may not support SMBus
connections to cards, cards that may not support SMBus, and resource
boxes that have varying degrees of functionality (if any).

At my disposal is a pretty light-weight COM to which I can bind
resource boxes one at a time via a fan-out switch. Having bound a
resource box to the COM, the hope is to somehow enumerate/discover
(but not provision) the PCIe tree of the resource box to obtain basic
information available from Configuration Space such as EP
vendor/device IDs, serial number (if available), BAR sizes, etc.

I've made some basic attempts with setpci, but have found that setpci
seems to really want the target devices to already have been
enumerated. libpciaccess seems to depend on this as well. Might any of
you know of a way by which I can manually perform configuration
reads/writes to devices which have not been enumerated by the system?

More heavily-handed, the rescan capabilities in
/sys/devices/.../rescan does both enumeration and provisioning, which
presents a different problem. The COM really doesn't have the
resources to provision arbitrary JBOF/JBOG populations, and I've been
able to prove that out. Using pci=assign-busses,hpbussize=<big number>
with only partially populated resource boxes, rescan has successfully
enumerated all of the buses, but complete provisioning fails (though
the kernel happily does not crash). Because the buses get fully
enumerated, I've then been able to extract the info I want via
lspci/setpci, and then /sys/devices/.../remove the branch.

This raises the question of whether someone might know of a way to ask
the system to perform enumeration without provisioning? (or somehow
suppress the provisioning?)

Bjorn brainstormed/suggested looking at setpci's -H1/H2 options,
trying ECAM from user space, and several other ideas, all of which
I'll be looking into. If any of you have some experience with trying
this kind of thing, or at least a reference or creative suggestion to
try I'd be grateful for your thoughts.

Again, thanks for your time.

Blessings,
Doug Meyer
