Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C475B441D66
	for <lists+linux-pci@lfdr.de>; Mon,  1 Nov 2021 16:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhKAP1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Nov 2021 11:27:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhKAP1N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Nov 2021 11:27:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6341B60F45;
        Mon,  1 Nov 2021 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635780279;
        bh=AhjF9OBDlbJIy6gVVjShyQN/Oy8Mlcnqsc4prlWt3gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+IjtyAXcOty1yUPozG/zOjPqn+3r6U4FZVbaT6+2zpdWuI3adduYD5DawwyCodEE
         smA6mIq2InTD6DdqcQKBYLEKO9fFWtTy7oQgOXIM0GLLrWJf4qmGS3GPZoRjnpXZgp
         cD1Ym+UxOhwsl2cnckMsTvx+rvXe7tRihGcXLgXlb1s29l5JAMDbP84gviNlMeq89I
         je6+xwyhfCaj558FW1gdxZqmwBkQOqQ6qCzP0hprXl5aQvoemh5PWNyZxR1Eyqp15i
         Zih1NKBaxPEK0RS8paPxXhT2Iyklm3Phyit0HGJPKxUV/CRvhW/GpUEg/W+RMe0aIU
         7VxNUQ77dqUwA==
Date:   Mon, 1 Nov 2021 15:24:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 7/9] PCI: brcmstb: Add control of subdevice voltage
 regulators
Message-ID: <YYAGsjTYOj8dglJS@sirena.org.uk>
References: <20211029200319.23475-1-jim2101024@gmail.com>
 <20211029200319.23475-8-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmtKctwfqQEF3iP7"
Content-Disposition: inline
In-Reply-To: <20211029200319.23475-8-jim2101024@gmail.com>
X-Cookie: Don't Worry, Be Happy.
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


--rmtKctwfqQEF3iP7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 29, 2021 at 04:03:15PM -0400, Jim Quinlan wrote:

> This Broadcom STB PCIe RC driver has one port and connects directly to one
> device, be it a switch or an endpoint.  We want to be able to turn on/off
> any regulators for that device.  Control of regulators is needed because of
> the chicken-and-egg situation: although the regulator is "owned" by the
> device and would be best handled by its driver, the device cannot be
> discovered and probed unless its regulator is already turned on.

Reviwed-by: Mark Brown <broonie@kernel.org>

--rmtKctwfqQEF3iP7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGABrEACgkQJNaLcl1U
h9DM9gf/afzECt/acF+dnOcpaYBW9Z0N4os0/Mlsi7uxvJFb6BuI3gXSqyFBUd0K
Ic7fD86AvnqAObDZUTgrViV/Y8ZZw2hJr+gR8TNkU46b+cWo/zscm+GCImrF8uyK
B2cjiGl2U3eVBv5W66yYKdMwmt1HjLN0Q6XIXZths19oIIqyfW9tLZ8Gc9W536Zv
/MQAsslBAS6LqaDFWSVPocqSxuSRPFx+o/UbIokM2qqkjfUbNphY5MgeSI9QwOEE
AxI8TIO/fttsll0kLfCe2VMGUikWEwDhRZ4+OAvygVDr+fQNhFuA7lBn1H2H0bec
QdzNcJkft0XhVnS/LafbHaHyg2a2Cg==
=nxKT
-----END PGP SIGNATURE-----

--rmtKctwfqQEF3iP7--
