Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFE5159EE3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2020 03:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgBLCC0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Feb 2020 21:02:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726968AbgBLCC0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Feb 2020 21:02:26 -0500
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAF5E2082F;
        Wed, 12 Feb 2020 02:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581472945;
        bh=htIylF4jROFJ6riEwNwA7KvXmOZ52qqEUUlhJZlLEoc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iCYPiTPYdnB2OI0v+huzasLYRjeRjhcTHmkhFmVrrmovvxZa6iqwp+hdE/5APs6Qq
         jBu77bwScSQIx3wgiVcysNX+EYw9eqDJNGd2H+xZUfFiv09v2HHMzkvYylf5QYmA1M
         a/bH3tJijMqMV4d8Ca8xN+gGXgXAyesWY/m8o6WY=
Received: by mail-qv1-f44.google.com with SMTP id g6so243218qvy.5;
        Tue, 11 Feb 2020 18:02:25 -0800 (PST)
X-Gm-Message-State: APjAAAUAA8dkeAnjGBfnurkPVxxFEcZELkDGmUqIHD9G8o13Fh/NOhzA
        X28u9Svlk5QBMTKzrYu5VYiRqatMtsVn+PpHaQ==
X-Google-Smtp-Source: APXvYqyZK3Vkicu73sUU5sruUOApIl6NuW57qMDLHWUYWwewOnHbEyttYZ0F4fQksB2kDUYtiSYWzYbNkVpIpCNsWz8=
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr5582693qvv.85.1581472944822;
 Tue, 11 Feb 2020 18:02:24 -0800 (PST)
MIME-Version: 1.0
References: <20200210123507.9491-1-kishon@ti.com> <20200210123507.9491-3-kishon@ti.com>
 <20200212015900.GA14509@bogus>
In-Reply-To: <20200212015900.GA14509@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Feb 2020 20:02:13 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKozWNJqQOoyMRZzRBsjY9_Y2NkMwRbWP=DPXC7ZYViNg@mail.gmail.com>
Message-ID: <CAL_JsqKozWNJqQOoyMRZzRBsjY9_Y2NkMwRbWP=DPXC7ZYViNg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: PCI: Convert PCIe Host/Endpoint in
 Cadence platform to DT schema
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 11, 2020 at 7:59 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, 10 Feb 2020 18:05:07 +0530, Kishon Vijay Abraham I wrote:
> > Include Cadence core DT schema and define the Cadence platform DT schema
> > for both Host and Endpoint mode. Note: The Cadence core DT schema could
> > be included for other platforms using Cadence PCIe core.
> >
> > Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> > ---
> >  .../bindings/pci/cdns,cdns-pcie-ep.txt        | 27 -------
> >  .../bindings/pci/cdns,cdns-pcie-ep.yaml       | 48 ++++++++++++
> >  .../bindings/pci/cdns,cdns-pcie-host.txt      | 66 ----------------
> >  .../bindings/pci/cdns,cdns-pcie-host.yaml     | 76 +++++++++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  5 files changed, 125 insertions(+), 94 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/cdns,cdns-pcie-host.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: 'device_type' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: 'ranges' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: '#address-cells' is a required property
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pci/cdns,cdns-pcie-ep.example.dt.yaml: pcie@fc000000: '#size-cells' is a required property

Node name needs to be pcie-ep@...
