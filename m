Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8844EBDB
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 18:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhKLRPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 12:15:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:32782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230051AbhKLRPn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 12:15:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 72E4160E98;
        Fri, 12 Nov 2021 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636737172;
        bh=XAhjClpN8pzzmnkn/qvi49BFy5bv+twtH7DITQsG29E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKQ6rCI1T8EYV/wI2GLXrZAWpaJSuvOMOVlFuslsGB8fT7+rvC1OGkLS6vCgdws89
         baw5OZrJ+zPvSqhkBJbo7iu5J6KL4gmUgouAFcGperIU9wsN5HBceR0WoXMytf99eU
         1oKw1S89WI30hg/hgqQodYUd65roTVRk8JAtnc5/dO20QyUuR1wTf4pBcsvHAAWCJj
         qTjTrmML5sX4xISnqZzYQG33vU3FO9Q/nBFUrvfGrAD3IZEcfwWmBfUzL99PTTc5uK
         r8X8BKWFFpSv+RVXUBvpiX4cAKCbjvhfaYmCWNK2P68igeWrBYLFJ67kxg/0Zrc8jQ
         N2jdh9RtKwPWw==
Received: by pali.im (Postfix)
        id 1C2B679D; Fri, 12 Nov 2021 18:12:50 +0100 (CET)
Date:   Fri, 12 Nov 2021 18:12:49 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH dt + pci 1/2] dt-bindings: Add
 'slot-power-limit-milliwatt' PCIe port property
Message-ID: <20211112171249.46xmj5zo3svm4qn2@pali>
References: <20211031150706.27873-1-kabel@kernel.org>
 <YY6HYM4T+A+tm85P@robh.at.kernel.org>
 <20211112153208.s4nuckz7js4fipce@pali>
 <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJ+FYFFcDEm-_Ow=9TERhhEMVKm3OCHyDdGo02onK7dmg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Friday 12 November 2021 10:30:01 Rob Herring wrote:
> On Fri, Nov 12, 2021 at 9:32 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Friday 12 November 2021 09:25:20 Rob Herring wrote:
> > > On Sun, Oct 31, 2021 at 04:07:05PM +0100, Marek Behún wrote:
> > > > +   If present, this property specifies slot power limit in milliwatts. Host
> > > > +   drivers can parse this property and use it for programming Root Port or host
> > > > +   bridge, or for composing and sending PCIe Set_Slot_Power_Limit messages
> > > > +   through the Root Port or host bridge when transitioning PCIe link from a
> > > > +   non-DL_Up Status to a DL_Up Status.
> > >
> > > If your slots are behind a switch, then doesn't this apply to any bridge
> > > port?
> >
> > The main issue here is that pci.txt (and also scheme on github) is
> > mixing host bridge and root ports into one node. This new property
> > should be defined at the same place where is supports-clkreq or
> > reset-gpios, as it belongs to them.
> 
> Unfortunately that ship has already sailed. So we can split things up,
> but we still have to allow for the existing cases. I'm happy to take
> changes splitting up pci-bus.yaml to 2 or 3 schemas (host bridge,
> root-port, and PCI(e)-PCI(e) bridge?).

Well, no problem. I just need to know how you want to handle backward
compatibility definitions in YAML. Because it is possible via versioning
(like in JSONSchema-like structures in OpenAPI versioning) or via
deprecated attributes or via defining two schemas (one strict and one
loose)... There are lot of options and I saw all these options in
different projects which use YAML or JSON.

I did not know about github repository, I always looked at schemas and
definitions only in linux kernel tree and external files which were
mentioned in kernel tree.

Something I wrote in my RFC email, but I wrote this email patch...
https://lore.kernel.org/linux-pci/20211023144252.z7ou2l2tvm6cvtf7@pali/

> > And you are right, that this new property should be defined only for
> > root ports and downstream ports of switch.
