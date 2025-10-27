Return-Path: <linux-pci+bounces-39461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFBC10C88
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3198035270F
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19CE315D44;
	Mon, 27 Oct 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB5HKJ28"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6B2D5A14
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592701; cv=none; b=BINlNqv1omESKqoMqkPvFTn89Hm7FMGisi7vrrn4mqBU8oXbqzJWWMvu6RmKqy1dJtHg0mD3PTmNGgiZrazK/l4GVsoctLN/jRBw+rH7/YbE61uG4E8UQVneFQraLMssQ72Rv7yrfF5ixBt3b0FJkvoA7V0JO/fe7dNrYED6W3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592701; c=relaxed/simple;
	bh=OelLsFAXU+Fsi6L9G9DsfhE25tyeK8sAjvICS4TYkjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IhOTvGi0TyxbQvw8uFu6XMFQl9N2puUr1lCrTH96VWGXifMJc76lFG7lURDC0SeD0Rwm1O+rQQ1ZgEX84cZjtqYNOgWsDbq3kbPUuea/yZVvLir+xVAvUI/rwyZt5FMXXkZ4vnK/emLuqM8k2LNsTiJ0WqgWVtVzqFFWYXdGGAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB5HKJ28; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6E8C19423
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 19:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761592701;
	bh=OelLsFAXU+Fsi6L9G9DsfhE25tyeK8sAjvICS4TYkjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KB5HKJ28F8/kbAyy/Q/svtw9GIrAEOUpMpuLaC0PpbPj3md1U87+g9eWafGuJyp8U
	 hzzUxK3bQnZ4ruOIO6VJQ42JK91fApvTgJ+F//716wnNjCWlQ536Bxa/xT1IQpkKAO
	 +7yLZAF6+XxgqxmpHVrdjdU+rgL+GFI3vQqe3yEwJ/cuGWk6moxv/p9J9z16XBj4Ql
	 PXLu2su5FiJzYJDFGrsLXH1YGmCcHhGJByyNrQQVqr//lWiLDdqIGbE01MYP7uH8kp
	 G8WpBhRnouuq/wgVcLBDMR52tCfQ2jgiBO3FeqEWBk7e99DwnIZu5oxO/mLnnhpA/w
	 IT1ZipdX/qs3A==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c52db2e41fso2128615a34.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 12:18:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUndVjS9PbQZWoRhi2ljM2XVPehnbOtt+4RFaJvscubpL6BttrUuzVpR1OPO8FSOX0SO5PaddGmpZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQmb+mchRJ3DTglmLJy6Gata6yvqP/mIF0JKJWApTyguTsjPn
	S4ocLjgcBfSK7uERP0o6ccg8EBzG/nsYNaW7+bmrLgajHsFVYHH80EizPAt26L2cNtnb2NsdnMj
	Z5E372qgSzcF4JQiiqKgLG9gmWNzTtZg=
X-Google-Smtp-Source: AGHT+IFw/Kkfe4EybU49GxVuXH5EGZG0kFSP8ZK9WdOoQTeBST5gRDl513Lon13x7GB2i3/6H9ZUgWPC2mPZJZ/P4Uo=
X-Received: by 2002:a05:6808:898e:20b0:44f:6d70:dd22 with SMTP id
 5614622812f47-44f6d7116f2mr61656b6e.25.1761592700822; Mon, 27 Oct 2025
 12:18:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015080710.1468409-1-badal.nilawar@intel.com> <20251015080710.1468409-4-badal.nilawar@intel.com>
In-Reply-To: <20251015080710.1468409-4-badal.nilawar@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 27 Oct 2025 20:18:09 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iAD0rVco+nNmwn4u1FYYsWHvjA=b+EeMY-O_W-H-RBBg@mail.gmail.com>
X-Gm-Features: AWmQ_bmO66YPlWauSlWEjdLGC2fURRE5csK6mLRxrX7YKlQmYrs1HNS-q848e1g
Message-ID: <CAJZ5v0iAD0rVco+nNmwn4u1FYYsWHvjA=b+EeMY-O_W-H-RBBg@mail.gmail.com>
Subject: Re: [PATCH v5 03/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com, rafael@kernel.org, 
	lenb@kernel.org, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, 
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com, 
	ville.syrjala@linux.intel.com, uma.shankar@intel.com, karthik.poosa@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 10:02=E2=80=AFAM Badal Nilawar <badal.nilawar@intel=
.com> wrote:
>
> From: Anshuman Gupta <anshuman.gupta@intel.com>
>
> Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10.

Can you please describe it here briefly for the benefit of people
without access to the PCI Firmware r3.3 specification?

And how is this related to the aux power limit the first two patches are ab=
out?

> Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> V2:
>  - Call acpi_check_dsm() to find method 0Bh supported
> V3(Kappuswamy/Rafael):
>  - %s/pci_warn/pci_info/ when PERST# Assertion Delay request fails
> ---
>  drivers/pci/pci-acpi.c   | 53 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  9 ++++++-
>  2 files changed, 61 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 74f118016b1d..230077200ce8 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1554,6 +1554,59 @@ int pci_acpi_request_d3cold_aux_power(struct pci_d=
ev *dev, u32 requested_mw,
>  }
>  EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>
> +/**
> + * pci_acpi_add_perst_assertion_delay - Request PERST# Delay via ACPI DS=
M
> + * @dev: PCI device instance
> + * @delay_us: Requested delay_us
> + *
> + * Request PERST# Assertion Delay to platform firmware, via Root Port/
> + * Switch Downstream Port ACPI _DSM Function 0Bh, for the specified
> + * PCI device.
> + * Evaluate the _DSM and handle the response accordingly.
> + *
> + * Return: returns 0 on success and errno on failure.
> + */
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us=
)
> +{
> +       union acpi_object in_obj =3D {
> +               .integer.type =3D ACPI_TYPE_INTEGER,
> +               .integer.value =3D delay_us,
> +       };
> +
> +       union acpi_object *out_obj;
> +       int result, ret =3D -EINVAL;
> +       struct pci_dev *bdev;
> +
> +       if (!dev)
> +               return -EINVAL;
> +
> +       bdev =3D pci_acpi_check_dsm(dev, 4, 1 << DSM_PCI_PERST_ASSERTION_=
DELAY);
> +
> +       if (IS_ERR(bdev))
> +               return PTR_ERR(bdev);
> +
> +       out_obj =3D acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
> +                                         &pci_acpi_dsm_guid, 4,
> +                                         DSM_PCI_PERST_ASSERTION_DELAY,
> +                                         &in_obj, ACPI_TYPE_INTEGER);
> +       if (!out_obj)
> +               return -EINVAL;
> +
> +       result =3D out_obj->integer.value;

Freeing out_obj here would allow error handling below to be more
straightforward.

> +
> +       if (result =3D=3D delay_us) {
> +               pci_info(dev, "PERST# Assertion Delay set to %u microseco=
nds\n", delay_us);
> +               ret =3D 0;
> +       } else {
> +               pci_info(dev, "PERST# Assertion Delay request failed, usi=
ng %u microseconds\n",
> +                        result);
> +       }
> +
> +       ACPI_FREE(out_obj);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_add_perst_assertion_delay);
> +
>  static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>         u8 val;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index ba48e7ddb360..4d8b8cea019e 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -122,6 +122,7 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_POWER_ON_RESET_DELAY           0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS     0x09
>  #define DSM_PCI_D3COLD_AUX_POWER_LIMIT         0x0A
> +#define DSM_PCI_PERST_ASSERTION_DELAY          0x0B
>
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> @@ -135,7 +136,7 @@ int pci_acpi_set_companion_lookup_hook(struct acpi_de=
vice *(*func)(struct pci_de
>  void pci_acpi_clear_companion_lookup_hook(void);
>  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested=
_mw,
>                                       u32 *retry_interval);
> -
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us=
);
>  #else  /* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> @@ -145,6 +146,12 @@ static inline int pci_acpi_request_d3cold_aux_power(=
struct pci_dev *dev,
>  {
>         return -EOPNOTSUPP;
>  }
> +
> +static inline int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev=
,
> +                                                    u32 delay_us)
> +{
> +       return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_ACPI */
>
>  #endif /* _PCI_ACPI_H_ */
> --

